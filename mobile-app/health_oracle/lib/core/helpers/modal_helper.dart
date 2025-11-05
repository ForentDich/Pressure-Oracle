import 'package:flutter/material.dart';
import 'package:health_oracle/core/theme/colors.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../widgets/bottom_entry_menu.dart';
import '../widgets/bottom_entry_actions.dart';


class ModalHelper {
  static Future<List<String>?> showBottomEntryMenu(BuildContext context) async {
    final selectedNotifier = ValueNotifier<Set<String>>({});

    try {
      return await WoltModalSheet.show<List<String>>(
        context: context,
        pageListBuilder: (modalSheetContext) => [
          WoltModalSheetPage(
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            hasTopBarLayer: false,
            isTopBarLayerAlwaysVisible: false,
            stickyActionBar: Builder(
              builder: (ctx) => BottomEntryActions(
                onCancel: () => Navigator.of(ctx).pop(),
                onSave: () {
                  final res = selectedNotifier.value.toList();
                  Navigator.of(ctx).pop(res);
                },
              ),
            ),
            child: Builder(
              builder: (modalSheetContext) => BottomEntryMenu(
                selectedNotifier: selectedNotifier,
              ),
            ),
          ),
        ],
        modalTypeBuilder: (_) => WoltModalType.bottomSheet(),
      );
    } catch (e) {
      print('WoltModalSheet failed, falling back to showModalBottomSheet: $e');

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
                BottomEntryMenu(selectedNotifier: selectedNotifier),
                Builder(builder: (ctx) {
                  return BottomEntryActions(
                    onCancel: () => Navigator.of(ctx).pop(),
                    onSave: () {
                      final res = selectedNotifier.value.toList();
                      Navigator.of(ctx).pop(res);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      );
    }
  }
}
