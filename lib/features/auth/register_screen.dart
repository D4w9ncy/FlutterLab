import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';

/// Екран реєстрації згідно з макетом "Реєстрація.png"
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
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
                      'Реєстрація',
                      style: AppTypography.h1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Створіть акаунт для спокійнішого побуту.',
                      style: AppTypography.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Поле імені
                    AppTextField(
                      label: 'Ім\'я',
                      hintText: 'Ваше ім\'я',
                      controller: _nameController,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Поле електронної пошти
                    AppTextField(
                      label: 'Електронна пошта',
                      hintText: 'ім\'я@пошта.укр',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Поле пароля
                    AppTextField(
                      label: 'Пароль',
                      hintText: 'Створіть пароль',
                      controller: _passwordController,
                      isPassword: true,
                      helperText: 'Не менше 8 символів',
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Поле підтвердження пароля
                    AppTextField(
                      label: 'Підтвердження пароля',
                      hintText: 'Повторіть пароль',
                      controller: _confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Кнопка "Зареєструватися"
                    PrimaryButton(
                      label: 'Зареєструватися',
                      onPressed: _onRegister,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Посилання на вхід
                    InkWell(
                      onTap: () => context.go('/login'),
                      borderRadius: AppSpacing.borderRadiusPill,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Вже є акаунт? ',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              'Увійти',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}

