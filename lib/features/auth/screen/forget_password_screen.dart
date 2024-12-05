import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/functions/app_validators.dart';
import 'package:flutter_application_1/features/auth/data/model/login_model.dart';
import '../../../core/classes/Keys.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../generated/l10n.dart';
import '../widget/logo_head_widget.dart';
import '../widget/phone_component.dart';
import 'base_verify_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        bottomNavigationBar: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddingSize.padding_16,
                  vertical: AppPaddingSize.padding_25),
              child: CreateModel(
                  onError: (val) {
                    Dialogs.showSnackBar(
                        message: '$val',
                        typeSnackBar: AnimatedSnackBarType.error);
                  },
                  withValidation: true,
                  onTap: () {
                    return (Keys.formKey.currentState?.validate() ?? false);
                  },
                  onSuccess: (LoginModel model) async {
                    Dialogs.showSnackBar(
                        message: S.of(context).send_code_success,
                        typeSnackBar: AnimatedSnackBarType.success);
                    Navigation.push(
                      BaseVerifyScreen(
                        title: S.of(context).Verify_your_Number,
                      ),
                    );
                  },
                  useCaseCallBack: (model) {
                    return null;
                  },
                  child: CustomButton(
                    text: S.of(context).Forget_Password,
                  )),
            )),
        body: SizedBox(
          height: 1.sh,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPaddingSize.padding_16,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: Keys.formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BackWidget(
                        titleWidget: LogoHeadWidget(
                          title: S.of(context).Forget_Password,
                          subTitle: S.of(context).Forget_Password,
                        ),
                      ),
                      const SizedBox(
                        height: AppPaddingSize.padding_30,
                      ),
                      PhoneComponentWidget(
                        onChangedPhoneCode: (p0) {},
                        initPhoneValue: null,
                        initPhoneCodeValue: '+964',
                        validator: (value) =>
                            AppValidators.validateFillFields(context, value),
                        title: S.of(context).Phone,
                        hintText: S.of(context).Enter_your_number,
                      ),
                      const SizedBox(
                        height: AppPaddingSize.padding_40,
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
