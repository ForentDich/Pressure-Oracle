import 'package:flutter/material.dart';

abstract class MetricInterface {
  String get title;
  String get unit;
  Gradient get gradient;
  IconData get icon;
  String get currentValue;
  String get description;
  String get lastUpdate;
}