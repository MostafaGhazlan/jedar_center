import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/core/constant/app_icons/app_icons.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';

import '../../../core/constant/app_colors/app_colors.dart';
import '../widget/logo_head_widget.dart';
import '../widget/text_field_section.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddingSize.padding_16,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackWidget(
                      titleWidget: LogoHeadWidget(
                        title: "set_pass_title",
                        subTitle: "set_pass_subtitle",
                      ),
                    ),
                    const SizedBox(
                      height: AppPaddingSize.padding_30,
                    ),
                    TextFieldSection(
                      title: "password",
                      hintText: "hint_password",
                      prefix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          passwordIcon,
                        ),
                      ),
                    ),
                    TextFieldSection(
                      title: "confirm_password",
                      hintText: "confirm_password_hint",
                      prefix: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          passwordIcon,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const CustomButton(
                      text: "signup",
                    ),
                    const SizedBox(
                      height: AppPaddingSize.padding_40,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
