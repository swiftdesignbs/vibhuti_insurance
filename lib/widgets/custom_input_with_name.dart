import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class CustomTextFieldWithName extends StatelessWidget {
  const CustomTextFieldWithName({
    super.key,
    required this.controller,
    this.hintText,
    this.ddName,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? ddName;
  final String? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ddName ?? '', style: AppTextTheme.subItemTitle),
        SizedBox(height: 10),
        Container(
          height: 60,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            keyboardType: keyboardType ?? TextInputType.text,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            style: AppTextTheme.subItemTitle.copyWith(color: Colors.black87),
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon != null
                  ? Image.asset(suffixIcon ?? '', height: 12, width: 12)
                  : null,
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTextTheme.primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                // ✅ Add focused border with theme color
                borderSide: BorderSide(
                  color: theme.primaryColor, // Use theme primary color
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              errorBorder: OutlineInputBorder(
                // ✅ Error state
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedErrorBorder: OutlineInputBorder(
                // ✅ Focused error state
                borderSide: BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(25),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              hintStyle: AppTextTheme.subItemTitle.copyWith(
                // ✅ Use theme for hint
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
