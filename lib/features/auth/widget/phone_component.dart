import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/constant/text_styles/font_size.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_text_form_field.dart';

import '../../../core/variables/variables.dart';

class PhoneComponentWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String?) validator;
  final Function(String)?
      onPhoneWithCodeChanged; // وظيفة جديدة تجمع الرقم مع رمز البلد
  final Function(CountryCode?)? onChangedPhoneCode;
  final String? initPhoneValue;
  final String? initPhoneCodeValue;

  const PhoneComponentWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.validator,
    this.initPhoneValue,
    this.initPhoneCodeValue,
    this.onPhoneWithCodeChanged,
    this.onChangedPhoneCode,
  });

  @override
  Widget build(BuildContext context) {
    String? currentCountryCode = initPhoneCodeValue ?? '+964';

    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            title,
            style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.black14,
              fontSize: AppFontSize.size_13,
            ),
          ),
        ),
        const SizedBox(height: AppPaddingSize.padding_8),
        CustomTextFormField(
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            if (onPhoneWithCodeChanged != null) {
              onPhoneWithCodeChanged!('$currentCountryCode$value');
            }
          },
          initValue: initPhoneValue,
          validator: (value) => validator(value),
          hintText: hintText,
          prefixIcon: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CountryCodePicker(
                    onChanged: (value) {
                      currentCountryCode = value.dialCode;
                      if (onChangedPhoneCode != null) {
                        onChangedPhoneCode!(value);
                      }
                    },
                    padding: EdgeInsets.zero,
                    countryList: elements,
                    showDropDownButton: false,
                    enabled: true,
                    initialSelection: initPhoneCodeValue ?? '+964',
                    favorite: const ['+964'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.grey9A,
                ),
                const SizedBox(width: AppPaddingSize.padding_5),
                SizedBox(
                  width: 0,
                  height: 35,
                  child: VerticalDivider(
                    color: AppColors.black1c.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppPaddingSize.padding_16),
      ],
    );
  }
}
