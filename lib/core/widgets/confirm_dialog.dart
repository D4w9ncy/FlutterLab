import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'danger_button.dart';
import 'secondary_button.dart';

/// Модальний діалог підтвердження небезпечної дії (видалення завдання або категорії).
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;

  const ConfirmDialog({
    super.key,
    this.title = 'Видалити завдання?',
    this.message = 'Цю дію неможливо скасувати.',
    this.confirmLabel = 'Видалити',
    this.cancelLabel = 'Скасувати',
    this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Видалити завдання?',
    String message = 'Цю дію неможливо скасувати.',
    String confirmLabel = 'Видалити',
    String cancelLabel = 'Скасувати',
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusXl,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.h2.copyWith(fontSize: 20),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                style: AppTypography.subtitle,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                    label: cancelLabel,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  DangerButton(
                    label: confirmLabel,
                    onPressed: () {
                      onConfirm?.call();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

