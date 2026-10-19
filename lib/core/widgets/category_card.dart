import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Картка категорії (використовується на екрані "Категорії" та у блоці категорій на "Головній")
class CategoryCard extends StatelessWidget {
  final CategoryItem category;
  final bool showProgress;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CategoryCard({
    super.key,
    required this.category,
    this.showProgress = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (showProgress) {
      // Вигляд для віджету на Головній сторінці
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Icon(
                    category.icon,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    category.name,
                    style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${category.taskCount} завдання',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusPill,
              child: LinearProgressIndicator(
                value: category.progress,
                minHeight: 6,
                backgroundColor: AppColors.borderLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${category.completedCount} із ${category.taskCount} виконано',
              style: AppTypography.bodySmall.copyWith(fontSize: 11),
            ),
          ],
        ),
      );
    }

    // Повноцінна картка для екрану Категорій
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppSpacing.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Icon(
              category.icon,
              size: 22,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category.name,
                  style: AppTypography.h3.copyWith(fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${category.taskCount} ${category.taskCount == 1 ? 'завдання' : 'завдань'}',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.primary),
            tooltip: 'Редагувати',
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.danger),
            tooltip: 'Видалити',
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

