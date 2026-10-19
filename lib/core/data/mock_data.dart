import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Статус виконання завдання
enum TaskStatus {
  new_('Нове', Icons.add_box_outlined, AppColors.neutral, AppColors.neutralContainer),
  inProgress('В процесі', Icons.access_time, AppColors.warning, AppColors.warningContainer),
  completed('Виконано', Icons.check, AppColors.success, AppColors.successContainer),
  overdue('Прострочено', Icons.warning_amber_rounded, AppColors.danger, AppColors.dangerContainer);

  final String label;
  final IconData icon;
  final Color color;
  final Color containerColor;

  const TaskStatus(this.label, this.icon, this.color, this.containerColor);
}

/// Модель завдання (hardcoded)
class TaskItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String dueDate;
  final String dueTime;
  final TaskStatus status;
  final bool isCompleted;

  const TaskItem({
    required this.id,
    required this.title,
    this.description = '',
    required this.category,
    required this.dueDate,
    required this.dueTime,
    required this.status,
    this.isCompleted = false,
  });

  String get formattedDeadline => '$dueDate · $dueTime';
}

/// Модель категорії (hardcoded)
class CategoryItem {
  final String id;
  final String name;
  final int taskCount;
  final int completedCount;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.taskCount,
    this.completedCount = 0,
    required this.icon,
  });

  double get progress => taskCount > 0 ? (completedCount / taskCount).clamp(0.0, 1.0) : 0.0;
}

/// Статичні mock-дані для застосунку (без бекенду)
class MockData {
  MockData._();

  static const String appName = 'Органайзер домашніх справ';
  static const String userName = 'Артем';
  static const String userEmail = 'user@пошта.укр';
  static const String userInitials = 'А';

  // Статистика на Головній сторінці
  static const int statNew = 5;
  static const int statInProgress = 2;
  static const int statCompleted = 12;
  static const int statOverdue = 1;

  // Категорії
  static const List<CategoryItem> categories = [
    CategoryItem(
      id: 'cat-kitchen',
      name: 'Кухня',
      taskCount: 4,
      completedCount: 2,
      icon: Icons.restaurant,
    ),
    CategoryItem(
      id: 'cat-cleaning',
      name: 'Прибирання',
      taskCount: 3,
      completedCount: 1,
      icon: Icons.cleaning_services_outlined,
    ),
    CategoryItem(
      id: 'cat-shopping',
      name: 'Покупки',
      taskCount: 2,
      completedCount: 1,
      icon: Icons.shopping_bag_outlined,
    ),
    CategoryItem(
      id: 'cat-repair',
      name: 'Ремонт',
      taskCount: 0,
      completedCount: 0,
      icon: Icons.build_outlined,
    ),
  ];

  // Основний список завдань
  static const List<TaskItem> tasks = [
    TaskItem(
      id: 'task-1',
      title: 'Протерти пил на полицях',
      description: 'Протерти пил на полицях у вітальні та спальні спеціальною серветкою з мікрофібри.',
      category: 'Прибирання',
      dueDate: '9 жовтня 2026',
      dueTime: '18:00',
      status: TaskStatus.overdue,
      isCompleted: false,
    ),
    TaskItem(
      id: 'task-2',
      title: 'Винести сміття',
      description: 'Зібрати сміття з кухні та санвузла, винести в контейнери для сортування.',
      category: 'Прибирання',
      dueDate: '10 жовтня 2026',
      dueTime: '09:00',
      status: TaskStatus.completed,
      isCompleted: true,
    ),
    TaskItem(
      id: 'task-3',
      title: 'Помити посуд',
      description: 'Помити тарілки, чашки та каструлю після обіду. Витерти чистий посуд і розкласти його по місцях. Наприкінці сполоснути раковину та протерти стільницю біля неї.',
      category: 'Кухня',
      dueDate: '10 жовтня 2026',
      dueTime: '14:30',
      status: TaskStatus.inProgress,
      isCompleted: false,
    ),
    TaskItem(
      id: 'task-4',
      title: 'Купити молоко',
      description: 'Купити пастеризоване молоко 2.5% та хліб.',
      category: 'Покупки',
      dueDate: '10 жовтня 2026',
      dueTime: '16:00',
      status: TaskStatus.new_,
      isCompleted: false,
    ),
    TaskItem(
      id: 'task-5',
      title: 'Помити підлогу в коридорі',
      description: 'Підмести та помити підлогу у передпокої та коридорі.',
      category: 'Прибирання',
      dueDate: '11 жовтня 2026',
      dueTime: '10:00',
      status: TaskStatus.new_,
      isCompleted: false,
    ),
    TaskItem(
      id: 'task-6',
      title: 'Купити засіб для миття посуду',
      description: 'Взяти екологічний миючий засіб без різкого запаху.',
      category: 'Покупки',
      dueDate: '11 жовтня 2026',
      dueTime: '12:00',
      status: TaskStatus.new_,
      isCompleted: false,
    ),
  ];

  // Завдання на сьогодні для Головної (перші 3 завдання)
  static List<TaskItem> get todayTasks => tasks.sublist(1, 4);

  // Одне прострочене завдання для блоку праворуч
  static TaskItem get overdueTask => tasks.first;
}

