import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:flutter_application_1/core/classes/keys.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/ui/screens/splash_screen.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_application_1/features/auth/widget/logo_head_widget.dart';
import 'package:flutter_application_1/features/auth/widget/text_field_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/utils/Navigation/navigation.dart';
import '../../../core/utils/functions/app_validators.dart';
import '../../../generated/l10n.dart';
import '../../configration/cubit/configration_cubit.dart';
import '../data/model/login_model.dart';
import 'forget_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.evenLighterBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
          ),
          body: Form(
            key: Keys.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddingSize.padding_16),
              physics: const BouncingScrollPhysics(),
              children: [
                LogoHeadWidget(
                    title: S.of(context).SignIn,
                    subTitle: S.of(context).SignIn_title),
                const SizedBox(
                  height: AppPaddingSize.padding_16,
                ),
                TextFieldSection(
                  onChanged: (p0) =>
                      context.read<AuthCubit>().loginParams.username = p0,
                  validator: (value) =>
                      AppValidators.validateFillFields(context, value),
                  title: S.of(context).User_Name,
                  hintText: S.of(context).Enter_user,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      personIcon,
                    ),
                  ),
                ),
                TextFieldSection(
                  suffixIcon: InkWell(
                    onTap: () =>
                        context.read<AuthCubit>().changeObscurePassword(),
                    child: Icon(
                        context.read<AuthCubit>().isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.remove_red_eye,
                        color: AppColors.primary),
                  ),
                  isObscure: context.read<AuthCubit>().isObscure,
                  onChanged: (p0) =>
                      context.read<AuthCubit>().loginParams.password = p0,
                  validator: (value) =>
                      AppValidators.validateFillFields(context, value),
                  title: S.of(context).Password,
                  hintText: S.of(context).Enter_password,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      passwordIcon,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppFontSize.size_8),
                      child: TextButton(
                        onPressed: () {
                          Navigation.push(const ForgetPasswordScreen());
                        },
                        child: Text(S.of(context).Forget_Password,
                            style: AppTextStyle.getBoldStyle(
                                color: AppColors.grey9A,
                                fontSize: AppFontSize.size_13)),
                      )),
                ),
                const SizedBox(
                  height: AppPaddingSize.padding_16,
                ),
                CreateModel<LoginModel>(
                  onSuccess: (LoginModel model) async {
                    CacheHelper.setToken(model.accessToken);
                    CacheHelper.setRefreshToken(model.refreshToken);
                    CacheHelper.setExpiresIn(model.expiresIn);
                    CacheHelper.setDateWithExpiry(model.expiresIn ?? 3600);
                    context.read<ConfigrationCubit>().config();
                    if (CacheHelper.currentUserInfo?.concurrencyStamp != null &&
                        CacheHelper.currentUserInfo?.id !=
                            "00000000-0000-0000-0000-000000000000") {
                      context
                              .read<ConfigrationCubit>()
                              .setDeviceIdParams
                              .concurrencyStamp =
                          CacheHelper.currentUserInfo?.concurrencyStamp ?? "";
                      context
                          .read<ConfigrationCubit>()
                          .setDeviceIdParams
                          .userId = CacheHelper.currentUserInfo?.id ?? "";

                      context
                          .read<ConfigrationCubit>()
                          .setDeviceIdParams
                          .deviceId = CacheHelper.deviceToken ?? "";

                      await context.read<ConfigrationCubit>().setDeviceId();
                    } else {
                      if (kDebugMode) {
                        print(
                            "____________________________________________+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                      }
                    }

                    Navigation.pushAndRemoveUntil(const SplashScreen());
                  },
                  onTap: () {
                    return (Keys.formKey.currentState?.validate() ?? false);
                  },
                  withValidation: true,
                  onError: (val) {
                    Dialogs.showSnackBar(
                        message: '$val',
                        typeSnackBar: AnimatedSnackBarType.error);
                  },
                  useCaseCallBack: (model) {
                    return context.read<AuthCubit>().login();
                  },
                  child: CustomButton(
                    text: S.of(context).SignIn,
                  ),
                ),
                const SizedBox(
                  height: AppPaddingSize.padding_16,
                ),
                const SizedBox(
                  height: AppPaddingSize.padding_25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.of(context).dont_Have_Account,
                          style: AppTextStyle.getMediumStyle(
                              color: AppColors.black14,
                              fontSize: AppFontSize.size_13)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.push( SignUpScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(S.of(context).Create_Account,
                            style: AppTextStyle.getBoldStyle(
                                color: AppColors.primary,
                                fontSize: AppFontSize.size_13)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
