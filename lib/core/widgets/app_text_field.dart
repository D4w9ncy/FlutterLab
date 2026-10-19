import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Стилізоване текстове поле введення з підтримкою пароля, підказок та станів помилки.
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isPassword;
  final bool readOnly;
  final bool enabled;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.initialValue,
    this.isPassword = false,
    this.readOnly = false,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.onChanged,
    this.onTap,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    Widget? suffix;
    if (widget.isPassword) {
      suffix = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.textSecondary,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else {
      suffix = widget.suffixIcon;
    }

    final bool isFieldDisabled = !widget.enabled || widget.readOnly;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          style: AppTypography.body.copyWith(
            color: isFieldDisabled ? AppColors.textSecondary : AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            filled: true,
            fillColor: isFieldDisabled ? const Color(0xFFF1F5F4) : AppColors.surface,
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffix,
            labelStyle: AppTypography.label.copyWith(
              color: hasError ? AppColors.danger : AppColors.textSecondary,
            ),
            floatingLabelStyle: AppTypography.label.copyWith(
              color: hasError ? AppColors.danger : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: hasError ? AppColors.danger : AppColors.border,
                width: hasError ? 1.5 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: hasError ? AppColors.danger : AppColors.primary,
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Text(
              widget.errorText!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.danger,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ] else if (widget.helperText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Text(
              widget.helperText!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

