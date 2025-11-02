import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'bottom_entry_category_tile.dart';
import 'bottom_entry_input_area.dart';


class BottomEntryMenu extends StatefulWidget {
  final void Function(List<String>)? onSave;
  final VoidCallback? onCancel;

  const BottomEntryMenu({
    super.key,
    this.onSave,
    this.onCancel,
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
  }

  /// Return the currently selected categories.
  List<String> getSelected() => _selected.toList();

  void _toggle(String cat) {
    setState(() {
      if (_selected.contains(cat)) {
        _selected.remove(cat);
      } else {
        _selected.add(cat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: This widget renders only the inner content. The modal shell
    // (rounded container / safe area) is provided by the caller so we don't
    // end up with a window-in-window effect when used inside WoltModalSheet.
    // Set paddings to match app design tokens (16px horizontal, 8px top, 12px bottom).
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
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
                child: Text('Добавить запись', style: TextStyles.titleMedium),
              ),

              const SizedBox(height: 8),

              // Category grid implemented using a small CategoryTile widget
              LayoutBuilder(
                builder: (context, constraints) {
                  // Use 12px spacing between tiles to align with design grid
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


Future<List<String>?> showBottomEntryMenu(BuildContext context) async {
  try {
    // Use a GlobalKey to read the internal state of the BottomEntryMenu so
    // the external action bar can access the current selection.
    final key = GlobalKey<_BottomEntryMenuState>();

    Widget _buildActionBar(BuildContext modalCtx) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.neutral200,
                  foregroundColor: AppColors.actionPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.of(modalCtx).pop(),
                child: const SizedBox(
                  height: 44,
                  child: Center(child: Text('Отмена')),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.actionPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  final res = key.currentState?.getSelected();
                  Navigator.of(modalCtx).pop(res);
                },
                child: const SizedBox(
                  height: 44,
                  child: Center(child: Text('Сохранить')),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return await WoltModalSheet.show<List<String>>(
      context: context,
      pageListBuilder: (modalSheetContext) => [
        WoltModalSheetPage(
          // disable the top bar layer to avoid extra spacing above content
          hasTopBarLayer: false,
          isTopBarLayerAlwaysVisible: false,
          // stickyActionBar pins this widget to the bottom of the modal
          stickyActionBar: Builder(builder: (ctx) => _buildActionBar(ctx)),
          child: Builder(
            builder: (modalSheetContext) => BottomEntryMenu(
              key: key,
              onCancel: () => Navigator.of(modalSheetContext).pop(),
              onSave: (res) => Navigator.of(modalSheetContext).pop(res),
            ),
          ),
        ),
      ],
      modalTypeBuilder: (_) => WoltModalType.bottomSheet(),
    );
  } catch (e) {
    // Fallback: show default modal with actions below content (pinned by being last child)
    // Log the error so it's visible during debugging, then fallback.
    // ignore: avoid_print
    print('WoltModalSheet failed, falling back to showModalBottomSheet: $e');

    final key = GlobalKey<_BottomEntryMenuState>();

    return showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        top: false,
        child: Padding(
          padding: MediaQuery.of(ctx).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomEntryMenu(
                key: key,
                onCancel: () => Navigator.of(ctx).pop(),
                onSave: (res) => Navigator.of(ctx).pop(res),
              ),
              Builder(builder: (ctx) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.neutral200,
                            foregroundColor: AppColors.actionPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const SizedBox(
                            height: 44,
                            child: Center(child: Text('Отмена')),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.actionPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            final res = key.currentState?.getSelected();
                            Navigator.of(ctx).pop(res);
                          },
                          child: const SizedBox(
                            height: 44,
                            child: Center(child: Text('Сохранить')),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
