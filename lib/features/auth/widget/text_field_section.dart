import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/constant/text_styles/font_size.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_text_form_field.dart';

class TextFieldSection extends StatelessWidget {
  final String title;
  final TextInputType? textInputType;
  final bool isObscure;
  final String hintText;
  final String? initValue;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? validator;
  const TextFieldSection(
      {super.key,
      required this.title,
      required this.hintText,
      this.prefix,
      this.onChanged,
      this.validator,
      this.suffixIcon,
      this.isObscure = false,
      this.initValue,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(title,
              style: AppTextStyle.getSemiBoldStyle(
                  color: AppColors.black14, fontSize: AppFontSize.size_13)),
        ),
        const SizedBox(
          height: AppPaddingSize.padding_8,
        ),
        CustomTextFormField(
            keyboardType: textInputType,
            initValue: initValue,
            isObscure: isObscure,
            suffixIcon: suffixIcon,
            validator:
                validator != null ? (value) => validator!(value ?? '') : null,
            onChanged: onChanged != null ? (value) => onChanged!(value) : null,
            prefixIcon: prefix,
            hintText: hintText),
        const SizedBox(
          height: AppPaddingSize.padding_16,
        ),
      ],
    );
  }
}
