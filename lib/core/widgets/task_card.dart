import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'priority_chip.dart';

/// Картка завдання (використовується на Головній та у Списку завдань)
class TaskCard extends StatelessWidget {
  final TaskItem task;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showDate;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onToggleComplete,
    this.onEdit,
    this.onDelete,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOverdue = task.status == TaskStatus.overdue;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppSpacing.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppSpacing.borderRadiusMd,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.borderRadiusMd,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Круглий чекбокс
                InkWell(
                  onTap: onToggleComplete,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted ? AppColors.primary : AppColors.border,
                        width: 1.8,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),

                // Назва та деталі
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        task.title,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          color: task.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs + 2),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.xs,
                        children: [
                          CategoryBadge(label: task.category),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isOverdue ? Icons.warning_amber_rounded : Icons.access_time,
                                size: 14,
                                color: isOverdue ? AppColors.danger : AppColors.textSecondary,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                showDate ? task.formattedDeadline : task.dueTime,
                                style: AppTypography.bodySmall.copyWith(
                                  color: isOverdue ? AppColors.danger : AppColors.textSecondary,
                                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                // Статус
                PriorityChip(status: task.status),

                const SizedBox(width: AppSpacing.xs),

                // Меню дій (три крапки)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onSelected: (value) {
                    if (value == 'view') {
                      onTap?.call();
                    } else if (value == 'edit') {
                      onEdit?.call();
                    } else if (value == 'delete') {
                      onDelete?.call();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'view',
                      child: Row(
                        children: [
                          Icon(Icons.visibility_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('Переглянути'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('Редагувати'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                          SizedBox(width: 8),
                          Text('Видалити', style: TextStyle(color: AppColors.danger)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

