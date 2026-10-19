import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/category_card.dart';
import '../../core/widgets/confirm_dialog.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/priority_chip.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/stat_card.dart';
import '../../core/widgets/task_card.dart';

/// Головний екран (Dashboard) згідно з макетом "Головна.png"
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 960;

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
                  // Верхній рядок: Вітання та кнопка "+ Додати завдання"
                  _buildGreetingHeader(context),
                  const SizedBox(height: AppSpacing.xxl),

                  // Рядок із 4 карток статистики
                  _buildStatsRow(isDesktop),
                  const SizedBox(height: AppSpacing.xxl),

                  // Двоколонковий вміст (Завдання на сьогодні + Прострочені та Категорії)
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ліва колонка (Завдання на сьогодні)
                        Expanded(
                          flex: 62,
                          child: _buildTodayTasksCard(context),
                        ),
                        const SizedBox(width: AppSpacing.xxl),

                        // Права колонка (Прострочені та Категорії)
                        Expanded(
                          flex: 38,
                          child: Column(
                            children: [
                              _buildOverdueCard(context),
                              const SizedBox(height: AppSpacing.xxl),
                              _buildCategoriesSummaryCard(context),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildTodayTasksCard(context),
                        const SizedBox(height: AppSpacing.xxl),
                        _buildOverdueCard(context),
                        const SizedBox(height: AppSpacing.xxl),
                        _buildCategoriesSummaryCard(context),
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

  Widget _buildGreetingHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 600;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Доброго дня!',
                    style: AppTypography.h1,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Субота, 10 жовтня · Трохи порядку — більше спокою.',
                    style: AppTypography.subtitle,
                  ),
                ],
              ),
            ),
            if (!isNarrow) ...[
              const SizedBox(width: AppSpacing.lg),
              PrimaryButton(
                label: 'Додати завдання',
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                isFullWidth: false,
                onPressed: () => context.go('/tasks/new'),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildStatsRow(bool isDesktop) {
    const cards = [
      StatCard(
        title: 'Нове',
        count: MockData.statNew,
        icon: Icons.add_box_outlined,
        iconColor: AppColors.neutral,
        iconBackgroundColor: AppColors.neutralContainer,
      ),
      StatCard(
        title: 'В процесі',
        count: MockData.statInProgress,
        icon: Icons.access_time,
        iconColor: AppColors.warning,
        iconBackgroundColor: AppColors.warningContainer,
      ),
      StatCard(
        title: 'Виконано',
        count: MockData.statCompleted,
        icon: Icons.check,
        iconColor: AppColors.success,
        iconBackgroundColor: AppColors.successContainer,
      ),
      StatCard(
        title: 'Прострочено',
        count: MockData.statOverdue,
        icon: Icons.warning_amber_rounded,
        iconColor: AppColors.danger,
        iconBackgroundColor: AppColors.dangerContainer,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: cards
            .map(
              (card) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  child: card,
                ),
              ),
            )
            .toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = (constraints.maxWidth - AppSpacing.md) / 2;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: cards.map((c) => SizedBox(width: itemWidth, child: c)).toList(),
        );
      },
    );
  }

  Widget _buildTodayTasksCard(BuildContext context) {
    final tasks = MockData.todayTasks;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppSpacing.cardShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Шапка блоку "На сьогодні"
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      'На сьогодні',
                      style: AppTypography.h2,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      '${tasks.length} завдання',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => context.go('/tasks'),
                  borderRadius: AppSpacing.borderRadiusSm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Усі завдання',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Список завдань
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: TaskCard(
                  task: task,
                  showDate: false,
                  onTap: () => context.go('/tasks/${task.id}'),
                  onEdit: () => context.go('/tasks/${task.id}/edit'),
                  onDelete: () => ConfirmDialog.show(context),
                ),
              );
            },
          ),

          // Нижня плашка прогресу
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxl,
              vertical: AppSpacing.lg,
            ),
            color: AppColors.primaryContainer.withValues(alpha: 0.5),
            child: Row(
              children: [
                const Icon(Icons.check, size: 18, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Виконано 1 із 3 на сьогодні',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusPill,
                    child: const LinearProgressIndicator(
                      value: 0.33,
                      minHeight: 6,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Text(
                  '33%',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverdueCard(BuildContext context) {
    final task = MockData.overdueTask;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: const Color(0xFFFBD5D5)),
        boxShadow: AppSpacing.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.danger,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Text(
                    'Прострочені',
                    style: AppTypography.h3,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.dangerContainer,
                  borderRadius: AppSpacing.borderRadiusPill,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(
                    color: AppColors.danger,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            task.title,
            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CategoryBadge(label: task.category),
              Text(
                'Учора, 18:00',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PriorityChip(status: TaskStatus.overdue),
              SecondaryButton(
                label: 'Перенести',
                textColor: AppColors.primary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Завдання перенесено')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSummaryCard(BuildContext context) {
    final categories = MockData.categories.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppSpacing.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Категорії',
                style: AppTypography.h3,
              ),
              Text(
                '${categories.length} категорії',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              return CategoryCard(
                category: categories[index],
                showProgress: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
