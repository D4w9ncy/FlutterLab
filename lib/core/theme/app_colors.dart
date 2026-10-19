import 'package:flutter/material.dart';

/// Колірна палітра застосунку відповідно до макетів у design/.
class AppColors {
  AppColors._();

  // Основні брендові кольори (глибокий смарагдовий / тіл)
  static const Color primary = Color(0xFF007A65);
  static const Color primaryDark = Color(0xFF005C4C);
  static const Color primaryLight = Color(0xFF00967D);
  static const Color primaryContainer = Color(0xFFE6F4F0);
  static const Color onPrimaryContainer = Color(0xFF004D40);

  // Фонові кольори та поверхні
  static const Color background = Color(0xFFF4F7F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF8FAF9);

  // Межі та розділювачі
  static const Color border = Color(0xFFD0D7D5);
  static const Color borderLight = Color(0xFFE6ECE9);
  static const Color divider = Color(0xFFE5EAE8);

  // Типографіка та текст
  static const Color textPrimary = Color(0xFF191C1B);
  static const Color textSecondary = Color(0xFF5C6B66);
  static const Color textMuted = Color(0xFF8A9893);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Статуси та акценти
  // Червоний (Прострочено / Помилка / Видалення)
  static const Color danger = Color(0xFFBA1A1A);
  static const Color dangerContainer = Color(0xFFFDE8E8);
  static const Color onDangerContainer = Color(0xFF900B0B);

  // Жовто-бурштиновий (В процесі / Попередження)
  static const Color warning = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color onWarningContainer = Color(0xFF92400E);

  // Зелений (Виконано / Успіх)
  static const Color success = Color(0xFF007A65);
  static const Color successContainer = Color(0xFFE6F4F0);
  static const Color onSuccessContainer = Color(0xFF004D40);

  // Нейтральний (Нове)
  static const Color neutral = Color(0xFF475569);
  static const Color neutralContainer = Color(0xFFF1F5F9);
  static const Color onNeutralContainer = Color(0xFF334155);

  // Тіні
  static const Color shadow = Color(0x0D000000);
}

