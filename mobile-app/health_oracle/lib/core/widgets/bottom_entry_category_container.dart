
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'bottom_entry_input_field.dart';

class BottomEntryCategoryContainer extends StatelessWidget {
  final Set<String> selectedCategories;
  final Map<String, Map<String, TextEditingController>> controllers;

  const BottomEntryCategoryContainer({
    super.key,
    required this.selectedCategories,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildInputFields(),
    );
  }

  List<Widget> _buildInputFields() {
    final List<Widget> fields = [];

    if (selectedCategories.contains('Давление')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Верхнее давление',
          unit: 'мм рт. ст.',
          controller: controllers['Давление']!['верхнее']!,
          hintText: '120',
          isRequired: true,
        ),
        const SizedBox(height: 14), 
        BottomEntryInputField(
          label: 'Нижнее давление',
          unit: 'мм рт. ст.',
          controller: controllers['Давление']!['нижнее']!,
          hintText: '80',
          isRequired: true,
        ),
        const SizedBox(height: 14), 
      ]);
    }

    if (selectedCategories.contains('Пульс')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Пульс',
          unit: 'уд/мин',
          controller: controllers['Пульс']!['пульс']!,
          hintText: '72',
          isRequired: true,
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (selectedCategories.contains('Вес')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Вес',
          unit: 'кг',
          controller: controllers['Вес']!['вес']!,
          hintText: '70.5',
          isRequired: true,
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (selectedCategories.contains('Сахар')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Уровень сахара',
          unit: 'ммоль/л',
          controller: controllers['Сахар']!['сахар']!,
          hintText: '5.2',
          isRequired: true,
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (fields.isNotEmpty && fields.last is SizedBox) {
      fields.removeLast();
    }

    return fields;
  }
}