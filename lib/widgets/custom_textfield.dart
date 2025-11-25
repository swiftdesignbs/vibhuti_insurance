import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.ddName,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true, // ✅ add this line
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
  final bool enabled; // ✅ add this line
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            keyboardType: keyboardType ?? TextInputType.text,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            textAlignVertical: TextAlignVertical.center,
            style: AppTextTheme.subItemTitle.copyWith(color: Colors.black87),
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        suffixIcon!,
                        height: 16,
                        width: 16,
                      ),
                    )
                  : null,
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(25),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              hintStyle: AppTextTheme.subItemTitle.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
