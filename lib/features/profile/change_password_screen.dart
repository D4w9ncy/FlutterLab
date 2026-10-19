import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';

/// Екран заміни пароля згідно з макетом "Заміна пароля.png"
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController(text: 'password123');
  final TextEditingController _newPasswordController = TextEditingController(text: 'newpassword123');
  final TextEditingController _confirmPasswordController = TextEditingController(text: 'newpassword123');

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Пароль успішно змінено')),
    );
    context.go('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxxl,
        vertical: AppSpacing.xxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Кнопка навігації назад
              InkWell(
                onTap: () => context.go('/profile'),
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
                        'До профілю',
                        style: AppTypography.button.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Картка форми заміни пароля
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
                    // Іконка замка
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Заголовок та підзаголовок
                    const Text(
                      'Заміна пароля',
                      style: AppTypography.h1,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text(
                      'Введіть поточний пароль і створіть новий для свого акаунта.',
                      style: AppTypography.subtitle,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Поточний пароль
                    AppTextField(
                      label: 'Поточний пароль',
                      controller: _currentPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Новий пароль
                    AppTextField(
                      label: 'Новий пароль',
                      controller: _newPasswordController,
                      isPassword: true,
                      helperText: 'Не менше 8 символів. Використовуйте літери та цифри.',
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Підтвердження нового пароля
                    AppTextField(
                      label: 'Підтвердження нового пароля',
                      controller: _confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Кнопки дій
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryButton(
                          label: 'Скасувати',
                          textColor: AppColors.primary,
                          onPressed: () => context.go('/profile'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        PrimaryButton(
                          label: 'Змінити',
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
}

