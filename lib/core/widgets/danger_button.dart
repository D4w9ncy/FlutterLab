import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Кнопка для деструктивних дій (видалення)
class DangerButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isTextOnly;
  final double height;

  const DangerButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isTextOnly = false,
    this.height = 44.0,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          label,
          style: AppTypography.button.copyWith(
            color: isTextOnly ? AppColors.danger : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    if (isTextOnly) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.danger,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        child: buttonContent,
      );
    }

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.danger,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusPill,
          ),
        ),
        child: buttonContent,
      ),
    );
  }
}

