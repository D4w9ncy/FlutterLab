import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';

/// Екран відновлення пароля згідно з макетом "Відновлення пароля.png"
class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'user@пошта.укр');
  bool _isSubmitted = true; // Відображається статично як у макеті

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    setState(() {
      _isSubmitted = true;
    });
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
                      'Відновлення пароля',
                      style: AppTypography.h1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Вкажіть пошту вашого акаунта. Ми надішлемо лист із посиланням для зміни пароля.',
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

                    // Банер успішного надсилання листа
                    if (_isSubmitted) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(alpha: 0.6),
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 22,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                'Якщо така пошта зареєстрована, лист уже надіслано',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.onPrimaryContainer,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],

                    // Кнопка "Надіслати"
                    PrimaryButton(
                      label: 'Надіслати',
                      onPressed: _onSubmit,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Кнопка повернення "Назад до входу"
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
                            const Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'Назад до входу',
                              style: AppTypography.button.copyWith(
                                color: AppColors.primary,
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
