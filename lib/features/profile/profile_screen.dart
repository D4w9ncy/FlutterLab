import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';

/// Екран профілю користувача згідно з макетом "Профіль.png"
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: MockData.userName);
  final TextEditingController _emailController = TextEditingController(text: MockData.userEmail);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Дані успішно збережено')),
    );
  }

  void _onLogout() {
    context.go('/login');
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
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок сторінки
              const Text(
                'Профіль',
                style: AppTypography.h1,
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'Ваші особисті дані та налаштування акаунта.',
                style: AppTypography.subtitle,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Картка налаштувань профілю
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
                    // Секція: Особисті дані з аватаром
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isWide = constraints.maxWidth >= 600;

                        final Widget avatarSection = Column(
                          children: [
                            CircleAvatar(
                              radius: 46,
                              backgroundColor: AppColors.primaryContainer,
                              child: Text(
                                MockData.userInitials,
                                style: const TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            TextButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Зміна фото')),
                                );
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              label: Text(
                                'Змінити фото',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              MockData.userName,
                              style: AppTypography.h3,
                            ),
                          ],
                        );

                        final Widget formSection = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Особисті дані',
                              style: AppTypography.h3,
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            AppTextField(
                              label: 'Ім\'я',
                              controller: _nameController,
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            AppTextField(
                              label: 'Електронна пошта',
                              controller: _emailController,
                              readOnly: true,
                              enabled: false,
                              suffixIcon: const Icon(Icons.lock_outline, size: 20),
                              helperText: 'Електронну пошту не можна змінити.',
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            Align(
                              alignment: Alignment.centerRight,
                              child: PrimaryButton(
                                label: 'Зберегти',
                                isFullWidth: false,
                                onPressed: _onSave,
                              ),
                            ),
                          ],
                        );

                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 180, child: avatarSection),
                              const SizedBox(width: AppSpacing.xxxl),
                              Expanded(child: formSection),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            avatarSection,
                            const SizedBox(height: AppSpacing.xxl),
                            formSection,
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xxl),
                    const Divider(),
                    const SizedBox(height: AppSpacing.xxl),

                    // Секція: Безпека акаунта
                    Row(
                      children: [
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
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Безпека акаунта',
                                style: AppTypography.h3,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Оновіть пароль, щоб захистити свої дані.',
                                style: AppTypography.subtitle,
                              ),
                            ],
                          ),
                        ),
                        SecondaryButton(
                          label: 'Змінити пароль',
                          textColor: AppColors.primary,
                          onPressed: () => context.go('/profile/change-password'),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xxl),
                    const Divider(),
                    const SizedBox(height: AppSpacing.xxl),

                    // Секція: Вихід з акаунта
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Вийти з акаунта на цьому пристрої.',
                          style: AppTypography.bodySmall,
                        ),
                        SecondaryButton(
                          label: 'Вийти',
                          isOutlined: true,
                          icon: const Icon(Icons.logout, size: 18, color: AppColors.primary),
                          textColor: AppColors.primary,
                          onPressed: _onLogout,
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

