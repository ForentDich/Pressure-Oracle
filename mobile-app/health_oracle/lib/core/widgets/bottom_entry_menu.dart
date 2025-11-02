import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../i18n/strings.dart';
import 'bottom_entry_category_tile.dart';
import 'bottom_entry_input_area.dart';


class BottomEntryMenu extends StatefulWidget {
  final void Function(List<String>)? onSave;
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

  @override
  void initState() {
    super.initState();
    _selected = {'Давление', 'Пульс'};
    widget.selectedNotifier?.value = Set<String>.from(_selected);
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
                child: Text(Strings.addEntryTitle, style: TextStyles.titleMedium),
              ),

              const SizedBox(height: 8),

              
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

             
              const SizedBox(height: 14),

              BottomEntryInputArea(selectedCategories: _selected.toList()),

              const SizedBox(height: 12),
            ],
          ),
        );
  }
}
