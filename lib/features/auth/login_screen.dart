import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';

/// Екран авторизації (Вхід) згідно з макетом "Вхід.png"
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'user@пошта.укр');
  final TextEditingController _passwordController = TextEditingController(text: 'password123');
  final bool _hasError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    // Без бізнес-логіки: перехід на Головну
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xxl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xxxl),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusXl,
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: AppSpacing.cardShadow,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Логотип та назва
                    const Center(
                      child: AppLogo(
                        iconSize: 42,
                        isHorizontal: true,
                        showText: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Заголовок та підзаголовок
                    const Text(
                      'Вхід',
                      style: AppTypography.h1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Раді бачити вас знову. Увійдіть до акаунта.',
                      style: AppTypography.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Поле електронної пошти
                    AppTextField(
                      label: 'Електронна пошта',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Поле пароля (з демонстрацією червоної рамки за потреби)
                    AppTextField(
                      label: 'Пароль',
                      controller: _passwordController,
                      isPassword: true,
                      errorText: _hasError ? 'Невірна пошта або пароль' : null,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Кнопка "Увійти"
                    PrimaryButton(
                      label: 'Увійти',
                      onPressed: _onLogin,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Розділювач "або"
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          child: Text(
                            'або',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Кнопка "Увійти через Google"
                    SecondaryButton(
                      label: 'Увійти через Google',
                      isOutlined: true,
                      isFullWidth: true,
                      textColor: AppColors.textPrimary,
                      icon: _buildGoogleIcon(),
                      onPressed: _onLogin,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Посилання "Забули пароль?"
                    SecondaryButton(
                      label: 'Забули пароль?',
                      onPressed: () => context.go('/password-recovery'),
                    ),
                    const Divider(height: AppSpacing.xxl),

                    // Посилання "Створити акаунт"
                    SecondaryButton(
                      label: 'Створити акаунт',
                      onPressed: () => context.go('/register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Зворотний зв\'язок')),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        mini: true,
        tooltip: 'Зворотний зв\'язок',
        child: const Icon(Icons.chat_bubble_outline, size: 20),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
