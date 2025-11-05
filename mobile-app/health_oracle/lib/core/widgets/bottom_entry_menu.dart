// bottom_entry_menu.dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../i18n/strings.dart';
import 'bottom_entry_category_tile.dart';
import 'bottom_entry_category_container.dart';
import 'bottom_entry_actions.dart';

class BottomEntryMenu extends StatefulWidget {
  final void Function(Map<String, Map<String, String>>)? onSave;
  final VoidCallback? onCancel;
  final ValueNotifier<Set<String>>? selectedNotifier;

  const BottomEntryMenu({
    super.key,
    this.onSave,
    this.onCancel,
    this.selectedNotifier,
  });

  @override
  State<BottomEntryMenu> createState() => _BottomEntryMenuState();
}

class _BottomEntryMenuState extends State<BottomEntryMenu> {
  final List<String> _categories = ['Давление', 'Пульс', 'Вес', 'Сахар'];
  late Set<String> _selected;
  late Map<String, Map<String, TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _selected = {'Давление', 'Пульс'};
    _initializeControllers();
    widget.selectedNotifier?.value = Set<String>.from(_selected);
  }

  void _initializeControllers() {
    _controllers = {
      'Давление': {
        'верхнее': TextEditingController(),
        'нижнее': TextEditingController(),
      },
      'Пульс': {
        'пульс': TextEditingController(),
      },
      'Вес': {
        'вес': TextEditingController(),
      },
      'Сахар': {
        'сахар': TextEditingController(),
      },
    };
  }

  void _toggle(String cat) {
    setState(() {
      if (_selected.contains(cat)) {
        _selected.remove(cat);
      } else {
        _selected.add(cat);
      }
      widget.selectedNotifier?.value = Set<String>.from(_selected);
    });

    
  }

  void _saveData() {
    final data = <String, Map<String, String>>{};
    
    for (final category in _selected) {
      data[category] = {};
      for (final entry in _controllers[category]!.entries) {
        data[category]![entry.key] = entry.value.text;
      }
    }
    
    widget.onSave?.call(data);
  }

  @override
  void dispose() {
    for (final categoryControllers in _controllers.values) {
      for (final controller in categoryControllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              Strings.addEntryTitle, 
              style: TextStyles.titleMedium.copyWith(
                fontSize: 20, 
              ),
            ),
          ),

          const SizedBox(height: 16), 

          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 12.0;
              final tileWidth = (constraints.maxWidth - spacing) / 2;

              final Map<String, Gradient> gradients = {
                'Давление': AppColors.pressureGradient,
                'Пульс': AppColors.pulseGradient,
                'Вес': AppColors.weightGradient,
                'Сахар': AppColors.sugarGradient,
              };

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: _categories.map((c) {
                  return SizedBox(
                    width: tileWidth,
                    child: BottomEntryCategoryTile(
                      title: c,
                      selected: _selected.contains(c),
                      gradient: gradients[c],
                      onTap: () => _toggle(c),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 24),
          
          
          BottomEntryCategoryContainer(
            selectedCategories: _selected,
            controllers: _controllers,
          ),
          
          const SizedBox(height: 24),
          

          BottomEntryActions(
            onCancel: widget.onCancel,
            onSave: _saveData,
          ),
        ],
      ),
    );
  }
}