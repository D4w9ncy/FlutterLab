import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/confirm_dialog.dart';
import '../../core/widgets/danger_button.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/priority_chip.dart';
import '../../core/widgets/secondary_button.dart';

/// Екран деталей завдання згідно з макетом "Деталі завдання.png"
class TaskDetailsScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailsScreen({super.key, required this.taskId});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskItem task;

  @override
  void initState() {
    super.initState();
    task = MockData.tasks.firstWhere(
      (t) => t.id == widget.taskId,
      orElse: () => MockData.tasks[2], // За замовчуванням "Помити посуд" як у макеті
    );
  }

  void _onComplete() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Завдання позначено як виконане')),
    );
  }

  void _onDelete() {
    ConfirmDialog.show(
      context,
      title: 'Видалити завдання?',
      message: 'Цю дію неможливо скасувати.',
      confirmLabel: 'Видалити',
      onConfirm: () {
        context.go('/tasks');
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
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxFormWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Кнопка повернення "До списку завдань"
              InkWell(
                onTap: () => context.go('/tasks'),
                borderRadius: AppSpacing.borderRadiusPill,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                    horizontal: AppSpacing.xs,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'До списку завдань',
                        style: AppTypography.button.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Картка деталей завдання
              Container(
                padding: const EdgeInsets.all(AppSpacing.xxxl),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: AppSpacing.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок та чіп статусу
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: AppTypography.h1,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        PriorityChip(status: task.status),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Метадані: Категорія та Строк виконання
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Категорія',
                                style: AppTypography.bodySmall,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              CategoryBadge(label: task.category),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Строк виконання',
                                style: AppTypography.bodySmall,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text(
                                    task.formattedDeadline,
                                    style: AppTypography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xxl),
                    const Divider(),
                    const SizedBox(height: AppSpacing.xxl),

                    // Секція: Опис
                    const Text(
                      'Опис',
                      style: AppTypography.h3,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      task.description.isNotEmpty
                          ? task.description
                          : 'Помити тарілки, чашки та каструлю після обіду. Витерти чистий посуд і розкласти його по місцях. Наприкінці сполоснути раковину та протерти стільницю біля неї.',
                      style: AppTypography.body.copyWith(height: 1.5),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Інформаційна плашка про статус
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.warningContainer.withValues(alpha: 0.5),
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Завдання вже розпочато',
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.onWarningContainer,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Коли все буде готово, натисніть «Виконано».',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.onWarningContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Кнопки дій: "Почати" та "Виконано"
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: null, // неактивна, бо завдання вже в процесі
                            icon: const Icon(Icons.play_arrow_outlined, size: 20),
                            label: const Text('Почати'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.neutralContainer,
                              foregroundColor: AppColors.neutral,
                              disabledBackgroundColor: AppColors.neutralContainer.withValues(alpha: 0.6),
                              disabledForegroundColor: AppColors.textMuted,
                              shape: RoundedRectangleBorder(
                                borderRadius: AppSpacing.borderRadiusPill,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: PrimaryButton(
                            label: 'Виконано',
                            icon: const Icon(Icons.check, size: 18, color: Colors.white),
                            onPressed: _onComplete,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xxl),
                    const Divider(),
                    const SizedBox(height: AppSpacing.xl),

                    // Нижня панель дій: "Редагувати" та "Видалити"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SecondaryButton(
                          label: 'Редагувати',
                          icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.primary),
                          textColor: AppColors.primary,
                          onPressed: () => context.go('/tasks/${task.id}/edit'),
                        ),
                        DangerButton(
                          label: 'Видалити',
                          icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                          isTextOnly: true,
                          onPressed: _onDelete,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
