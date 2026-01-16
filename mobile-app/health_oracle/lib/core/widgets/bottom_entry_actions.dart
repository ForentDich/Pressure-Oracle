import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../i18n/l10n_extension.dart';

typedef VoidCallbackNullable = void Function();

class BottomEntryActions extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSave;

  const BottomEntryActions({super.key, this.onCancel, this.onSave});

  @override
  Widget build(BuildContext context) {
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
              onPressed: onCancel,
              child: SizedBox(
                height: 44,
                child: Center(child: Text(context.l10n.cancel)),
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
              onPressed: onSave,
              child: SizedBox(
                height: 44,
                child: Center(child: Text(context.l10n.save)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
