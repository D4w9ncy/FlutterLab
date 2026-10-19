import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Віджет логотипу застосунку з макетів
class AppLogo extends StatelessWidget {
  final double iconSize;
  final bool showText;
  final bool isHorizontal;

  const AppLogo({
    super.key,
    this.iconSize = 48.0,
    this.showText = true,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget logoIcon = Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.home_outlined,
              size: iconSize * 0.62,
              color: AppColors.primary,
            ),
            Positioned(
              bottom: iconSize * 0.16,
              child: Icon(
                Icons.check,
                size: iconSize * 0.30,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );

    if (!showText) {
      return logoIcon;
    }

    final Widget textWidget = Column(
      crossAxisAlignment: isHorizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Органайзер',
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: iconSize * 0.32,
            height: 1.15,
          ),
        ),
        Text(
          'домашніх справ',
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: iconSize * 0.32,
            height: 1.15,
          ),
        ),
      ],
    );

    if (isHorizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logoIcon,
          const SizedBox(width: AppSpacing.md),
          textWidget,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logoIcon,
        const SizedBox(height: AppSpacing.sm),
        textWidget,
      ],
    );
  }
}

