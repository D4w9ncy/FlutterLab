import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/confirm_dialog.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/priority_chip.dart';
import '../../core/widgets/task_card.dart';

/// Екран списку всіх завдань згідно з макетом "Список завдань.png"
class TasksListScreen extends StatefulWidget {
  const TasksListScreen({super.key});

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  String _selectedCategory = 'Усі категорії';
  String _selectedStatusFilter = 'Усі';

  final List<String> _categories = [
    'Усі категорії',
    'Прибирання',
    'Кухня',
    'Покупки',
    'Ремонт',
  ];

  final List<String> _statusFilters = [
    'Усі',
    'Нове',
    'В процесі',
    'Виконано',
    'Прострочено',
  ];

  @override
  Widget build(BuildContext context) {
    final tasks = MockData.tasks;

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
              // Верхній блок заголовка з кнопкою створення завдання
              _buildHeader(context, tasks.length),
              const SizedBox(height: AppSpacing.xxl),

              // Панель фільтрів (Категорії + Статуси)
              _buildFiltersBar(),
              const SizedBox(height: AppSpacing.xxl),

              // Список завдань (картки)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    showDate: true,
                    onTap: () => context.go('/tasks/${task.id}'),
                    onEdit: () => context.go('/tasks/${task.id}/edit'),
                    onDelete: () => ConfirmDialog.show(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int taskCount) {
    return LayoutBuilder(
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
                  'Завдання',
                  style: AppTypography.h1,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$taskCount завдань · Від найближчого строку до найдальшого',
                  style: AppTypography.subtitle,
                ),
              ],
            ),
            if (!isNarrow)
              PrimaryButton(
                label: 'Додати завдання',
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                isFullWidth: false,
                onPressed: () => context.go('/tasks/new'),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFiltersBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWrap = constraints.maxWidth < 750;

        final dropdown = Container(
          width: isWrap ? double.infinity : 200,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
              style: AppTypography.body,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
              items: _categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
            ),
          ),
        );

        final chips = Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _statusFilters.map((filter) {
            return StatusFilterChip(
              label: filter,
              isSelected: _selectedStatusFilter == filter,
              onTap: () {
                setState(() {
                  _selectedStatusFilter = filter;
                });
              },
            );
          }).toList(),
        );

        if (isWrap) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dropdown,
              const SizedBox(height: AppSpacing.md),
              chips,
            ],
          );
        }

        return Row(
          children: [
            dropdown,
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: chips),
          ],
        );
      },
    );
  }
}
