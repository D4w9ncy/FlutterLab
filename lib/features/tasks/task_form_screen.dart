import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';

/// Екран створення або редагування завдання згідно з макетами "Форма завдання.png" та "Форма завдання-1.png"
class TaskFormScreen extends StatefulWidget {
  final String? taskId;

  const TaskFormScreen({super.key, this.taskId});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  String? _selectedCategory;

  final List<String> _categories = [
    'Оберіть категорію',
    'Прибирання',
    'Кухня',
    'Покупки',
    'Ремонт',
    'Домашні справи',
  ];

  bool get isEditing => widget.taskId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final task = MockData.tasks.firstWhere(
        (t) => t.id == widget.taskId,
        orElse: () => const TaskItem(
          id: 'task-custom',
          title: 'Полити кімнатні рослини',
          description: '',
          category: 'Домашні справи',
          dueDate: '10 жовтня 2026',
          dueTime: '18:00',
          status: TaskStatus.new_,
        ),
      );
      _titleController = TextEditingController(text: task.title);
      _descriptionController = TextEditingController(text: task.description);
      _dateController = TextEditingController(text: task.dueDate);
      _timeController = TextEditingController(text: task.dueTime);
      _selectedCategory = _categories.contains(task.category) ? task.category : 'Домашні справи';
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _dateController = TextEditingController(text: '10 жовтня 2026');
      _timeController = TextEditingController(text: '18:00');
      _selectedCategory = 'Оберіть категорію';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditing ? 'Завдання успішно відредаговано' : 'Завдання успішно додано',
        ),
      ),
    );
    context.go('/tasks');
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle = isEditing ? 'Редагування завдання' : 'Нове завдання';
    final String pageSubtitle = isEditing
        ? 'Редагуйте домашню справу та заплануйте зручний час.'
        : 'Додайте домашню справу та заплануйте зручний час.';

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
              // Кнопка навігації назад
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

              // Картка форми
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
                    Text(
                      pageTitle,
                      style: AppTypography.h1,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      pageSubtitle,
                      style: AppTypography.subtitle,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '* Обов\'язкове поле',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Поле: Назва *
                    AppTextField(
                      label: 'Назва *',
                      hintText: 'Наприклад, полити кімнатні рослини',
                      controller: _titleController,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Поле: Опис
                    AppTextField(
                      label: 'Опис',
                      hintText: 'Додайте деталі, які допоможуть виконати завдання',
                      controller: _descriptionController,
                      maxLines: 4,
                      minLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Поле: Категорія (Dropdown)
                    _buildCategoryDropdown(),
                    const SizedBox(height: AppSpacing.xxl),

                    // Секція: Строк виконання
                    Text(
                      'Строк виконання',
                      style: AppTypography.label.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Поля Дати та Часу в ряд
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isNarrow = constraints.maxWidth < 450;

                        final dateField = AppTextField(
                          label: 'Дата',
                          controller: _dateController,
                          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
                        );

                        final timeField = AppTextField(
                          label: 'Час',
                          controller: _timeController,
                          suffixIcon: const Icon(Icons.access_time, size: 20),
                        );

                        if (isNarrow) {
                          return Column(
                            children: [
                              dateField,
                              const SizedBox(height: AppSpacing.lg),
                              timeField,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(child: dateField),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(child: timeField),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xxxl),
                    const Divider(),
                    const SizedBox(height: AppSpacing.xl),

                    // Кнопки дій
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryButton(
                          label: 'Скасувати',
                          textColor: AppColors.primary,
                          onPressed: () => context.go('/tasks'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        PrimaryButton(
                          label: 'Зберегти',
                          isFullWidth: false,
                          onPressed: _onSave,
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

  Widget _buildCategoryDropdown() {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Категорія',
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
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
  }
}
