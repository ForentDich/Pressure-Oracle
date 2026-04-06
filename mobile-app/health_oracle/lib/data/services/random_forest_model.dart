import 'dart:convert';
import 'package:flutter/services.dart';

/// Универсальный интерпретатор RandomForest, загружаемого из JSON.
class RandomForestModel {
  final String id;
  final int nClasses;
  final int nFeatures;
  final List<String> featureNames;
  final List<String> classNames;
  final List<_DecisionTree> _trees;
  final List<double>? _imputerStats;
  final List<int>? _indicatorFeatures;

  RandomForestModel._({
    required this.id,
    required this.nClasses,
    required this.nFeatures,
    required this.featureNames,
    required this.classNames,
    required List<_DecisionTree> trees,
    List<double>? imputerStats,
    List<int>? indicatorFeatures,
  })  : _trees = trees,
        _imputerStats = imputerStats,
        _indicatorFeatures = indicatorFeatures;

  /// Загружает модель из JSON-ассета.
  static Future<RandomForestModel> load(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;

    final treesJson = json['trees'] as List;
    final trees = treesJson.map((t) => _DecisionTree.fromJson(t)).toList();

    List<double>? impStats;
    List<int>? indFeats;
    if (json.containsKey('imputer')) {
      final imp = json['imputer'] as Map<String, dynamic>;
      impStats = (imp['statistics'] as List).map((e) => (e as num).toDouble()).toList();
      if (imp.containsKey('indicator_features')) {
        indFeats = (imp['indicator_features'] as List).map((e) => (e as num).toInt()).toList();
      }
    }

    return RandomForestModel._(
      id: json['id'] as String,
      nClasses: json['n_classes'] as int,
      nFeatures: json['n_features'] as int,
      featureNames: (json['feature_names'] as List).cast<String>(),
      classNames: (json['class_names'] as List).cast<String>(),
      trees: trees,
      imputerStats: impStats,
      indicatorFeatures: indFeats,
    );
  }

  /// Предсказание класса. Возвращает индекс класса (sklearn-like: argmax(mean_proba)).
  int predict(List<double> features) {
    final probs = predictProbabilities(features);
    if (probs.isEmpty) return 0;

    var bestIdx = 0;
    var best = probs[0];
    for (var i = 1; i < probs.length; i++) {
      if (probs[i] > best) {
        best = probs[i];
        bestIdx = i;
      }
    }
    return bestIdx;
  }

  /// Вероятности по классам (mean of per-tree leaf probabilities).
  List<double> predictProbabilities(List<double> features) {
    final processed = _preprocess(features);
    final votes = List<double>.filled(nClasses, 0);

    for (final tree in _trees) {
      final p = tree.predictProba(processed); // already sums to 1
      for (int i = 0; i < nClasses; i++) {
        votes[i] += p[i];
      }
    }

    if (_trees.isNotEmpty) {
      for (int i = 0; i < votes.length; i++) {
        votes[i] /= _trees.length;
      }
    }
    return votes;
  }

  /// Предобработка: Imputer (замена NaN медианой + индикаторы).
  List<double> _preprocess(List<double> features) {
    if (_imputerStats == null) return features;

    final result = List<double>.from(features);

    // Заменяем NaN на медиану
    for (int i = 0; i < result.length && i < _imputerStats.length; i++) {
      if (result[i].isNaN) {
        result[i] = _imputerStats[i];
      }
    }

    // Добавляем индикаторные признаки (1 = было NaN)
    if (_indicatorFeatures != null) {
      for (final idx in _indicatorFeatures) {
        result.add(idx < features.length && features[idx].isNaN ? 1.0 : 0.0);
      }
    }

    return result;
  }
}

/// Одно дерево решений из ансамбля.
class _DecisionTree {
  final List<int> feature;
  final List<double> threshold;
  final List<int> childrenLeft;
  final List<int> childrenRight;
  final List<List<double>> value; // <-- was int

  _DecisionTree({
    required this.feature,
    required this.threshold,
    required this.childrenLeft,
    required this.childrenRight,
    required this.value,
  });

  factory _DecisionTree.fromJson(Map<String, dynamic> json) {
    return _DecisionTree(
      feature: (json['feature'] as List).cast<int>(),
      threshold: (json['threshold'] as List).map((e) => (e as num).toDouble()).toList(),
      childrenLeft: (json['children_left'] as List).cast<int>(),
      childrenRight: (json['children_right'] as List).cast<int>(),
      value: (json['value'] as List).map((row) {
        // row is List<num> in JSON (old versions may be int-only)
        return (row as List).map((v) => (v as num).toDouble()).toList();
      }).toList(),
    );
  }

  /// Возвращает вероятности по классам для данного вектора признаков (leaf distribution normalized).
  List<double> predictProba(List<double> features) {
    int nodeId = 0;
    while (childrenLeft[nodeId] != -1) {
      final f = feature[nodeId];
      if (f < 0 || f >= features.length) break;
      if (features[f] <= threshold[nodeId]) {
        nodeId = childrenLeft[nodeId];
      } else {
        nodeId = childrenRight[nodeId];
      }
    }

    final counts = value[nodeId];
    final total = counts.fold<double>(0, (a, b) => a + b);
    if (total <= 0) return List<double>.filled(counts.length, 0);

    return counts.map((c) => c / total).toList();
  }
}
