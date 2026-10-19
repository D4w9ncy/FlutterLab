import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterlab/app/app.dart';
import 'package:flutterlab/core/widgets/app_shell.dart';
import 'package:flutterlab/core/widgets/stat_card.dart';
import 'package:flutterlab/features/auth/login_screen.dart';
import 'package:flutterlab/features/auth/password_recovery_screen.dart';
import 'package:flutterlab/features/auth/register_screen.dart';
import 'package:flutterlab/features/categories/categories_screen.dart';
import 'package:flutterlab/features/home/home_screen.dart';
import 'package:flutterlab/features/profile/change_password_screen.dart';
import 'package:flutterlab/features/profile/profile_screen.dart';
import 'package:flutterlab/features/tasks/task_details_screen.dart';
import 'package:flutterlab/features/tasks/task_form_screen.dart';
import 'package:flutterlab/features/tasks/tasks_list_screen.dart';

void main() {
  testWidgets('Full flow navigation and screen test', (WidgetTester tester) async {
    // Встановлюємо розмір екрана для тесту (десктопний вигляд)
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Початковий запуск застосунку (екран Вхід)
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Вхід'), findsWidgets);
    expect(find.text('Увійти'), findsOneWidget);

    // 2. Перехід на екран Реєстрації
    final registerButton = find.text('Створити акаунт');
    expect(registerButton, findsOneWidget);
    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.text('Реєстрація'), findsWidgets);

    // 3. Повернення на екран Входу
    final loginLink = find.text('Увійти');
    expect(loginLink, findsOneWidget);
    await tester.ensureVisible(loginLink);
    await tester.tap(loginLink);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);

    // 4. Перехід на Відновлення пароля
    final forgotPassword = find.text('Забули пароль?');
    expect(forgotPassword, findsOneWidget);
    await tester.ensureVisible(forgotPassword);
    await tester.tap(forgotPassword);
    await tester.pumpAndSettle();

    expect(find.byType(PasswordRecoveryScreen), findsOneWidget);
    expect(find.text('Відновлення пароля'), findsWidgets);

    // 5. Повернення до входу та вхід у систему
    final backToLogin = find.text('Назад до входу');
    expect(backToLogin, findsOneWidget);
    await tester.ensureVisible(backToLogin);
    await tester.tap(backToLogin);
    await tester.pumpAndSettle();

    final enterButton = find.text('Увійти');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    // 6. Головний екран (AppShell + HomeScreen)
    expect(find.byType(AppShell), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Доброго дня!'), findsOneWidget);
    expect(find.byType(StatCard), findsNWidgets(4));
    expect(find.text('Нове'), findsWidgets);
    expect(find.text('В процесі'), findsWidgets);
    expect(find.text('Виконано'), findsWidgets);
    expect(find.text('Прострочено'), findsWidgets);

    // 7. Перехід у Завдання через бічну панель
    final tasksNav = find.text('Завдання').first;
    await tester.tap(tasksNav);
    await tester.pumpAndSettle();

    expect(find.byType(TasksListScreen), findsOneWidget);
    expect(find.text('Усі категорії'), findsOneWidget);

    // 8. Перехід на форму нового завдання
    final addTaskButton = find.text('Додати завдання').first;
    await tester.tap(addTaskButton);
    await tester.pumpAndSettle();

    expect(find.byType(TaskFormScreen), findsOneWidget);
    expect(find.text('Нове завдання'), findsWidgets);

    // Повернення до списку завдань
    final backToTasks = find.text('До списку завдань');
    await tester.tap(backToTasks);
    await tester.pumpAndSettle();

    expect(find.byType(TasksListScreen), findsOneWidget);

    // 9. Відкриття деталей завдання зі списку
    final firstTask = find.text('Протерти пил на полицях');
    expect(firstTask, findsOneWidget);
    await tester.tap(firstTask);
    await tester.pumpAndSettle();

    expect(find.byType(TaskDetailsScreen), findsOneWidget);
    expect(find.text('Строк виконання'), findsOneWidget);

    // 10. Перехід у Категорії через бічну панель
    final categoriesNav = find.text('Категорії').first;
    await tester.tap(categoriesNav);
    await tester.pumpAndSettle();

    expect(find.byType(CategoriesScreen), findsOneWidget);
    expect(find.text('Кухня'), findsOneWidget);
    expect(find.text('Прибирання'), findsOneWidget);

    // Відкриття діалогу створення нової категорії
    final addCategoryButton = find.text('Додати категорію');
    await tester.tap(addCategoryButton);
    await tester.pumpAndSettle();

    expect(find.text('Нова категорія'), findsOneWidget);
    expect(find.text('Скасувати'), findsOneWidget);

    final cancelDialog = find.text('Скасувати');
    await tester.tap(cancelDialog);
    await tester.pumpAndSettle();

    // 11. Перехід у Профіль
    final profileNav = find.text('Профіль').first;
    await tester.tap(profileNav);
    await tester.pumpAndSettle();

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Особисті дані'), findsOneWidget);

    // Перехід на екран заміни пароля
    final changePasswordBtn = find.text('Змінити пароль');
    await tester.ensureVisible(changePasswordBtn);
    await tester.tap(changePasswordBtn);
    await tester.pumpAndSettle();

    expect(find.byType(ChangePasswordScreen), findsOneWidget);
    expect(find.text('Поточний пароль'), findsOneWidget);

    // Повернення до профілю
    final backToProfile = find.text('До профілю');
    await tester.tap(backToProfile);
    await tester.pumpAndSettle();

    expect(find.byType(ProfileScreen), findsOneWidget);

    // 12. Вихід з акаунта
    final logoutBtn = find.text('Вийти');
    await tester.ensureVisible(logoutBtn);
    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
