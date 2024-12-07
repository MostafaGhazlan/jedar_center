import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/profile/cubit/profile_cubit.dart';
import 'package:flutter_application_1/features/profile/cubit/profile_states.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/classes/keys.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/ui/widgets/back_widget.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../generated/l10n.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        body:
            BlocBuilder<ProfileCubit, ProfileStates>(builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddingSize.padding_16,
              ),
              child: Form(
                key: Keys.formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 1.sh,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h),
                          BackWidget(
                            title: S.of(context).Change_Language,
                          ),
                          const SizedBox(
                            height: AppPaddingSize.padding_30,
                          ),
                          Text(
                            S.of(context).Change_Language,
                            style: AppTextStyle.getMediumStyle(
                                fontSize: AppFontSize.size_16,
                                color: AppColors.primary),
                          ),
                          const SizedBox(
                            height: AppPaddingSize.padding_30,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ProfileCubit>().changeLang("en");
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: prefs!.getString("lang") == "en"
                                    ? AppColors.greyE5
                                    : AppColors.white,
                                border: Border.all(color: AppColors.greyDD),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppPaddingSize.padding_14,
                                    horizontal: AppPaddingSize.padding_25),
                                child: Text(
                                  S.of(context).English,
                                  style: AppTextStyle.getMediumStyle(
                                      fontSize: AppFontSize.size_16,
                                      color: prefs!.getString("lang") == "en"
                                          ? AppColors.primary
                                          : AppColors.black14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppPaddingSize.padding_30,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ProfileCubit>().changeLang("ar");
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: prefs!.getString("lang") == "ar"
                                    ? AppColors.greyE5
                                    : AppColors.white,
                                border: Border.all(color: AppColors.greyDD),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppPaddingSize.padding_14,
                                    horizontal: AppPaddingSize.padding_25),
                                child: Text(
                                  S.of(context).Arabic,
                                  style: AppTextStyle.getMediumStyle(
                                      fontSize: AppFontSize.size_16,
                                      color: prefs!.getString("lang") == "ar"
                                          ? AppColors.primary
                                          : AppColors.black14),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CustomButton(
                            onPressed: () {
                              Navigation.pop();
                            },
                            text: S.of(context).Save,
                          ),
                          const SizedBox(
                            height: AppPaddingSize.padding_50,
                          )
                        ]),
                  ),
                ),
              ));
        }));
  }
}
