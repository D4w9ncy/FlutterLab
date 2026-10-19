import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/category_card.dart';
import '../../core/widgets/confirm_dialog.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';

/// Екран категорій згідно з макетом "Категорії.png"
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<CategoryItem> _categories = List.of(MockData.categories);

  void _showCategoryDialog([CategoryItem? category]) {
    final bool isEditing = category != null;
    final controller = TextEditingController(text: isEditing ? category.name : 'Балкон');

    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusXl,
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditing ? 'Редагувати категорію' : 'Нова категорія',
                    style: AppTypography.h2,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Об\'єднайте схожі домашні справи в одну категорію.',
                    style: AppTypography.subtitle,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  AppTextField(
                    label: 'Назва',
                    controller: controller,
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SecondaryButton(
                        label: 'Скасувати',
                        textColor: AppColors.primary,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      PrimaryButton(
                        label: 'Зберегти',
                        isFullWidth: false,
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isEditing ? 'Категорію оновлено' : 'Категорію створено',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmDeleteCategory(CategoryItem category) {
    ConfirmDialog.show(
      context,
      title: 'Видалити категорію?',
      message: 'Усі завдання в категорії «${category.name}» залишаться без категорії.',
      confirmLabel: 'Видалити',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Категорію «${category.name}» видалено')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxxl,
        vertical: AppSpacing.xxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Верхній заголовок з кнопкою додавання
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isNarrow = constraints.maxWidth < 600;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Категорії',
                            style: AppTypography.h1,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${_categories.length} категорії · 9 домашніх справ',
                            style: AppTypography.subtitle,
                          ),
                        ],
                      ),
                      if (!isNarrow)
                        PrimaryButton(
                          label: 'Додати категорію',
                          icon: const Icon(Icons.add, size: 18, color: Colors.white),
                          isFullWidth: false,
                          onPressed: () => _showCategoryDialog(),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Список карток категорій
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return CategoryCard(
                    category: category,
                    onEdit: () => _showCategoryDialog(category),
                    onDelete: () => _confirmDeleteCategory(category),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Підказка внизу сторінки
              Text(
                'Редагуйте назви категорій або додавайте нові для своїх справ.',
                style: AppTypography.subtitle.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
