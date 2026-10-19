import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/app_shell.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/password_recovery_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/change_password_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/tasks/task_details_screen.dart';
import '../features/tasks/task_form_screen.dart';
import '../features/tasks/tasks_list_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Конфігурація маршрутизації застосунку за допомогою go_router
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    // Екрани авторизації (без бічної панелі навігації)
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/password-recovery',
      builder: (context, state) => const PasswordRecoveryScreen(),
    ),

    // Головний каркас із бічною навігаційною панеллю
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppShell(state: state, child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksListScreen(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const TaskFormScreen(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? 'task-1';
                return TaskDetailsScreen(taskId: id);
              },
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    return TaskFormScreen(taskId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) => const CategoriesScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'change-password',
              builder: (context, state) => const ChangePasswordScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

