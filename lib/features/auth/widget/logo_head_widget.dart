import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/font_size.dart';
import 'package:flutter_application_1/core/ui/widgets/logo_widget.dart';
import '../../../core/constant/text_styles/app_text_style.dart';

class LogoHeadWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const LogoHeadWidget(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 60,
        ),
        const LogoWidget(
          height: 85,
          width: 85,
        ),
        const SizedBox(
          height: AppPaddingSize.padding_40,
        ),
        Text(title,
            style: AppTextStyle.getBoldStyle(
                color: AppColors.primary, fontSize: AppFontSize.size_20)),
        const SizedBox(
          height: AppPaddingSize.padding_5,
        ),
        Text(subTitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.getRegularStyle(
                color: AppColors.grey9A, fontSize: AppFontSize.size_13)),
        const SizedBox(
          height: AppPaddingSize.padding_25,
        ),
      ],
    );
  }
}
