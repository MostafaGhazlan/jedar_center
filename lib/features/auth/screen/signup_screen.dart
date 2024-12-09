import 'dart:math';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/core/constant/app_icons/app_icons.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/functions/app_validators.dart';
import '../../../core/classes/Keys.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/utils/Navigation/navigation.dart';
import '../../../generated/l10n.dart';
import '../widget/logo_head_widget.dart';
import '../widget/phone_component.dart';
import '../widget/text_field_section.dart';
import 'base_verify_screen.dart';

class SignUpScreen extends StatelessWidget {
  final Widget? headerWidget;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  SignUpScreen({super.key, this.headerWidget}) {
    _initializeNotifications();
  }
  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _showLocalNotification(int code) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Your Verification Code',
      'Code: $code',
      platformChannelSpecifics,
    );
  }

  int _generateRandomCode() {
    final Random random = Random();
    return 1000 + random.nextInt(9000); // توليد رقم بين 1000 و 9999
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.evenLighterBackground,
          body: Form(
            key: Keys.formKey,
            child: ListView(
              children: [
                headerWidget ??
                    BackWidget(
                      titleWidget: LogoHeadWidget(
                        title: S.of(context).Signup,
                        subTitle: S.of(context).welcome,
                      ),
                    ),
                TextFieldSection(
                  onChanged: (p0) {
                    context.read<AuthCubit>().registerParams.name = p0;
                  },
                  validator: (value) =>
                      AppValidators.validateFillFields(context, value),
                  title: S.of(context).First_Name,
                  hintText: S.of(context).First_Name,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      personIcon,
                    ),
                  ),
                ),
                TextFieldSection(
                  onChanged: (p0) {
                    context.read<AuthCubit>().registerParams.username = p0;
                  },
                  validator: (value) =>
                      AppValidators.validateFillFields(context, value),
                  title: S.of(context).User_Name,
                  hintText: S.of(context).User_Name,
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
                  onChanged: (p0) {
                    context.read<AuthCubit>().registerParams.password = p0;
                  },
                  validator: (value) =>
                      AppValidators.validateFillFields(context, value),
                  title: S.of(context).Password,
                  hintText: S.of(context).Password,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      passwordIcon,
                    ),
                  ),
                ),
                TextFieldSection(
                  validator: (p0) {
                    AppValidators.validateEmailFields(context, p0);
                  },
                  onChanged: (p0) {
                    context.read<AuthCubit>().registerParams.email = p0;
                  },
                  title: S.of(context).Email,
                  hintText: S.of(context).Email,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      emailIcon,
                    ),
                  ),
                ),
                PhoneComponentWidget(
                  onPhoneWithCodeChanged: (value) {
                    context.read<AuthCubit>().registerParams.phoneNumber =
                        value;
                  },
                  initPhoneCodeValue: "+964",
                  validator: (value) =>
                      AppValidators.validateFillFields(context, value),
                  title: S.of(context).Phone,
                  hintText: S.of(context).Enter_your_number,
                ),
                const SizedBox(
                  height: AppPaddingSize.padding_20,
                ),
                // const Spacer(),
                // CreateModel(
                //     onError: (val) {
                //       Dialogs.showSnackBar(
                //           message: '$val',
                //           typeSnackBar: AnimatedSnackBarType.error);
                //     },
                //     withValidation: true,
                //     onTap: () {
                //       return (Keys.formKey.currentState?.validate() ?? false);
                //     },
                //     onSuccess: (RegisterModel model) async {
                //       Dialogs.showSnackBar(
                //           message: "Registe Success",
                //           typeSnackBar: AnimatedSnackBarType.success);
                //       Navigator.pop(context);
                //     },
                //     useCaseCallBack: (model) {
                //       return context.read<AuthCubit>().sigup();
                //     },
                //     child: CustomButton(
                //       text: S.of(context).Save,
                //     )),
                CustomButton(
                  text: "Save",
                  onPressed: () {
                    if (Keys.formKey.currentState?.validate() ?? false) {
                      final int randomCode = _generateRandomCode();

                      _showLocalNotification(randomCode);

                      Navigation.push(BaseVerifyScreen(
                        title: S.of(context).Verify_your_Number,
                        verificationCode: randomCode,
                      ));
                    } else {
                      AnimatedSnackBar.material(
                        'Please fill all required fields',
                        type: AnimatedSnackBarType.error,
                      ).show(context);
                    }
                  },
                ),

                const SizedBox(
                  height: AppPaddingSize.padding_30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
