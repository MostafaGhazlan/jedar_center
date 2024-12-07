import 'dart:async';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/boilerplate/create_model/cubits/create_model_cubit.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/constant/text_styles/font_size.dart';
import 'package:flutter_application_1/core/ui/dialogs/dialogs.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../generated/l10n.dart';
import '../widget/logo_head_widget.dart';
import '../widget/pin_code_text_field.dart';

class BaseVerifyScreen extends StatefulWidget {
  final String title;
  final sendCodeUseCase;
  final sendCodeCall;
  final verifyCodeUseCase;
  const BaseVerifyScreen(
      {super.key,
      required this.title,
      this.sendCodeUseCase,
      this.verifyCodeUseCase,
      this.sendCodeCall});

  @override
  State<BaseVerifyScreen> createState() => _BaseVerifyScreenState();
}

class _BaseVerifyScreenState extends State<BaseVerifyScreen> {
  TextEditingController? controller;
  static const int maxSecond = 30;
  int second = maxSecond;
  Timer? timer;
  final key = GlobalKey();
  CreateModelCubit? createModelCubit;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (second > 0) {
            second--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            child: Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddingSize.padding_16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BackWidget(
                        titleWidget: LogoHeadWidget(
                          title: S.of(context).verification_code,
                          subTitle: S.of(context).sent_verification,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: PinCodeTextFieldWidget(
                          pinCodeController: controller!,
                          whenDone: () {
                            createModelCubit!.createModel();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('00:$second',
                                style: AppTextStyle.getBoldStyle(
                                    color: AppColors.blueFace,
                                    fontSize: AppFontSize.size_13)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          second == 0
                              ? CreateModel(
                                  onTap: () {},
                                  onCubitCreated: (cubit) {},
                                  onSuccess: (model) {
                                    second = maxSecond;
                                    startTimer();
                                  },
                                  useCaseCallBack: (model) {
                                    return null;
                                  },
                                  withValidation: false,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(S.of(context).Resend_code,
                                        style: AppTextStyle.getBoldStyle(
                                            color: AppColors.primary,
                                            fontSize: AppFontSize.size_13)),
                                  ))
                              : const SizedBox(),
                        ],
                      ),
                      const Spacer(),
                      CreateModel(
                        onCubitCreated: (cubit) {
                          createModelCubit = cubit;
                        },
                        onTap: () {},
                        onError: (message) {
                          Dialogs.showErrorSnackBar(
                            message: message,
                            typeSnackBar: AnimatedSnackBarType.error,
                          );
                        },
                        onSuccess: (model) async {
                          Dialogs.showErrorSnackBar(
                            message: S.of(context).changed,
                            typeSnackBar: AnimatedSnackBarType.success,
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        useCaseCallBack: (model) {
                          return null;
                        },
                        withValidation: false,
                        child: CustomButton(
                          text: S.of(context).verification,
                        ),
                      ),
                      const SizedBox(
                        height: AppPaddingSize.padding_40,
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
