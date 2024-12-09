import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/ui/dialogs/dialogs.dart';
import 'package:flutter_application_1/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/constant/text_styles/font_size.dart';
import '../../../core/constant/app_colors/app_colors.dart';

class PinCodeTextFieldWidget extends StatefulWidget {
  final VoidCallback? whenDone;
  final int? verificationCode;

  final String? Function(String?)? validator;
  final TextEditingController pinCodeController;
  const PinCodeTextFieldWidget(
      {super.key,
      required this.pinCodeController,
      this.validator,
      this.whenDone,
      this.verificationCode});

  @override
  State<PinCodeTextFieldWidget> createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: widget.validator,
      appContext: context,
      textStyle: AppTextStyle.getBoldStyle(
          color: AppColors.primary, fontSize: AppFontSize.size_13),
      length: 4,
      controller: widget.pinCodeController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 100),
      backgroundColor: Colors.transparent,
      cursorColor: AppColors.black1c,
      cursorHeight: 20.h,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      onChanged: (value) {
        if (value.characters.length == 4) {
          if (int.tryParse(value) == widget.verificationCode) {
            if (widget.whenDone != null) {
              widget.whenDone!();
            }
          } else {
            Dialogs.showErrorSnackBar(message: S.of(context).code_incorrect);
          }
        }
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: kIsWeb ? 46 : 46.h,
        fieldWidth: kIsWeb ? 46 : 46.w,
        activeFillColor: Colors.white,
        activeBorderWidth: 0,
        borderWidth: 0,
        activeColor: AppColors.primary,
        errorBorderColor: Colors.transparent,
        disabledColor: Colors.transparent,
        inactiveColor: AppColors.grey9A,
        selectedColor: AppColors.grey9A,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        selectedBorderWidth: 0,
        errorBorderWidth: 0,
        disabledBorderWidth: 0,
        inactiveBorderWidth: 0,
      ),
    );
  }
}
