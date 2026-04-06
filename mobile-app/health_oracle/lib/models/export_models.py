"""
Экспорт sklearn .pkl моделей в JSON-формат для использования в Flutter.

Использование:
  cd lib/models
  python export_models.py

Результат: два файла в ../../assets/models/
  - hypertension_model.json  (Модель 1 — классификация гипертонии)
  - kidney_model.json        (Модель 2 — хрон. болезни почек)
"""

import json
import os
import numpy as np
from joblib import load


def tree_to_dict(tree):
    """Конвертирует sklearn DecisionTree в словарь."""
    return {
        'feature': tree.feature.tolist(),
        'threshold': [round(float(x), 6) for x in tree.threshold],
        'children_left': tree.children_left.tolist(),
        'children_right': tree.children_right.tolist(),
        # value[node][0] — массив голосов/весов по классам (в sklearn float)
        'value': [[round(float(v), 6) for v in node[0]] for node in tree.value],
    }


def export_random_forest(pipeline, output_path, meta):
    """
    Извлекает RandomForestClassifier из pipeline и сохраняет в JSON.
    pipeline может быть:
      - imblearn.pipeline.Pipeline  (SMOTE + RF)
      - sklearn.pipeline.Pipeline   (Imputer + RF)
      - просто RandomForestClassifier
    """
    rf = None
    imputer_stats = None

    if hasattr(pipeline, 'named_steps'):
        for name, step in pipeline.named_steps.items():
            # RandomForestClassifier
            if hasattr(step, 'estimators_'):
                rf = step
            # SimpleImputer
            if hasattr(step, 'statistics_'):
                imp = {
                    'statistics': [round(float(x), 6) for x in step.statistics_],
                }
                if hasattr(step, 'indicator_') and step.indicator_ is not None:
                    imp['indicator_features'] = step.indicator_.features_.tolist()
                imputer_stats = imp
    elif hasattr(pipeline, 'estimators_'):
        rf = pipeline
    else:
        raise ValueError("Не удалось найти RandomForestClassifier")

    trees = [tree_to_dict(est.tree_) for est in rf.estimators_]

    model_json = {
        'model_type': 'random_forest',
        'n_classes': int(rf.n_classes_) if isinstance(rf.n_classes_, (int, np.integer)) else int(rf.n_classes_[0]) if hasattr(rf.n_classes_, '__len__') else int(rf.n_classes_),
        'n_features': int(rf.n_features_in_),
        'n_estimators': len(trees),
        'trees': trees,
    }
    model_json.update(meta)

    if imputer_stats:
        model_json['imputer'] = imputer_stats

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(model_json, f, ensure_ascii=False)

    size_kb = os.path.getsize(output_path) / 1024
    print(f"  ✓ {output_path}  ({len(trees)} деревьев, {size_kb:.0f} KB)")


# ── Модель 1: гипертония ─────────────────────────────────────────
print("▸ Загрузка model.pkl …")
m1 = load("model.pkl")

# Порядок признаков при обучении (LabelEncoded категории + возраст):
# Кодировка — алфавитный порядок (LabelEncoder)
export_random_forest(m1, "../../assets/models/hypertension_model.json", {
    'id': 'hypertension',
    'feature_names': [
        'Sex',
        'Category_SBP',
        'Category_DBP',
        'Category_BMI',
        'Category_Pulse',
        'Age',
    ],
    'class_names': [
        'Normal',
        'Prehypertension',
        'Stage 1 hypertension',
        'Stage 2 hypertension',
    ],
})


# ── Модель 2: хронические болезни почек ───────────────────────────
print("▸ Загрузка second_model.pkl …")
m2 = load("second_model.pkl")

# Для второй модели — автоматически извлекаем число признаков
# и будем передавать фичи в том же порядке
n_feat = m2[-1].n_features_in_ if hasattr(m2, '__getitem__') else m2.n_features_in_
print(f"  Число признаков модели 2: {n_feat}")

export_random_forest(m2, "../../assets/models/kidney_model.json", {
    'id': 'kidney',
    'feature_names': [
        'Blood_Pressure_Abnormality',
        'Level_of_Hemoglobin',
        'Genetic_Pedigree_Coefficient',
        'Age',
        'BMI',
        'Sex',
        'Smoking',
        'Physical_activity',
        'salt_content_in_the_diet',
        'alcohol_consumption_per_day',
        'Level_of_Stress',
    ],
    'class_names': ['No', 'Yes'],
})

print("\n✅ Готово! Файлы моделей в assets/models/")
