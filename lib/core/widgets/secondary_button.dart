import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Вторинна дія (контурна або текстова кнопка).
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isOutlined;
  final bool isFullWidth;
  final Color? textColor;
  final double height;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.isFullWidth = false,
    this.textColor,
    this.height = 44.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = textColor ?? AppColors.primary;

    final Widget buttonContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          label,
          style: AppTypography.button.copyWith(
            color: effectiveColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    if (isOutlined) {
      return SizedBox(
        width: isFullWidth ? double.infinity : null,
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusPill,
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          ),
          child: buttonContent,
        ),
      );
    }

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: effectiveColor,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusPill,
          ),
        ),
        child: buttonContent,
      ),
    );
  }
}

