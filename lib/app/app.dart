import 'package:flutter/material.dart';
import '../core/data/mock_data.dart';
import '../core/theme/app_theme.dart';
import 'router.dart';

/// Головний віджет додатку з використанням MaterialApp.router
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: MockData.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}

