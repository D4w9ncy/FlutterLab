import 'package:flutter/material.dart';

/// Стандартні відступи, радіуси заокруглення та розміри з макету.
class AppSpacing {
  AppSpacing._();

  // Базові відступи
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;

  // Радіуси заокруглень
  static const double radiusXs = 6.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusPill = 999.0;

  // Border radius об'єкти
  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderRadiusPill = BorderRadius.circular(radiusPill);

  // Максимальна ширина контейнерів для форми та карток
  static const double maxFormWidth = 720.0;
  static const double maxContentWidth = 1200.0;

  // Тінь карток
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ];
}

