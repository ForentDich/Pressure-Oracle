import 'package:flutter/material.dart';
import 'package:health_oracle/core/theme/colors.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../widgets/bottom_entry_menu.dart';


class ModalHelper {
  static Future<Map<String, Map<String, String>>?> showBottomEntryMenu(BuildContext context) async {
    final selectedNotifier = ValueNotifier<Set<String>>({});

    try {
      return await WoltModalSheet.show<Map<String, Map<String, String>>>(
        context: context,
        pageListBuilder: (modalSheetContext) => [
          WoltModalSheetPage(
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            hasTopBarLayer: false,
            isTopBarLayerAlwaysVisible: false,
            child: Builder(
              builder: (ctx) => BottomEntryMenu(
                selectedNotifier: selectedNotifier,
                onCancel: () => Navigator.of(ctx).pop(),
                onSave: (data) => Navigator.of(ctx).pop(data),
              ),
            ),
          ),
        ],
        modalTypeBuilder: (_) => WoltModalType.bottomSheet(),
      );
    } catch (e) {
      print('WoltModalSheet failed, falling back to showModalBottomSheet: $e');

      return showModalBottomSheet<Map<String, Map<String, String>>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (ctx) => SafeArea(
          top: false,
          child: Padding(
            padding: MediaQuery.of(ctx).viewInsets,
            child: BottomEntryMenu(
              selectedNotifier: selectedNotifier,
              onCancel: () => Navigator.of(ctx).pop(),
              onSave: (data) => Navigator.of(ctx).pop(data),
            ),
          ),
        ),
      );
    }
  }
}
