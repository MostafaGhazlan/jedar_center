import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/classes/keys.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/back_widget.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/utils/functions/app_validators.dart';
import '../../../generated/l10n.dart';
import '../../auth/widget/text_field_section.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_states.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      bloc: context.read<ProfileCubit>()..clearPassword(),
      builder: (context, state) => Scaffold(
          backgroundColor: AppColors.evenLighterBackground,
          body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddingSize.padding_16,
              ),
              child: Form(
                key: Keys.formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 1.sh,
                    child: Column(children: [
                      SizedBox(height: 50.h),
                      BackWidget(
                        title: S.of(context).Change_Password,
                      ),
                      const SizedBox(
                        height: AppPaddingSize.padding_30,
                      ),
                      TextFieldSection(
                        onChanged: (p0) {},
                        isObscure: context.read<ProfileCubit>().oldObscure,
                        suffixIcon: InkWell(
                          onTap: () => context
                              .read<ProfileCubit>()
                              .changeOldObscurePassword(),
                          child: Icon(
                              context.read<ProfileCubit>().oldObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye,
                              color: AppColors.primary),
                        ),
                        validator: (value) =>
                            AppValidators.validateFillFields(context, value),
                        title: S.of(context).Old_password,
                        hintText: S.of(context).Old_password,
                        prefix: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            passwordIcon,
                          ),
                        ),
                      ),
                      TextFieldSection(
                        onChanged: (p0) {},
                        isObscure: context.read<ProfileCubit>().newObscure,
                        suffixIcon: InkWell(
                          onTap: () => context
                              .read<ProfileCubit>()
                              .changeNewObscurePassword(),
                          child: Icon(
                              context.read<ProfileCubit>().newObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye,
                              color: AppColors.primary),
                        ),
                        validator: (value) =>
                            AppValidators.validateFillFields(context, value),
                        title: S.of(context).Password,
                        hintText: S.of(context).Enter_password,
                        prefix: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            passwordIcon,
                          ),
                        ),
                      ),
                      TextFieldSection(
                        onChanged: (p0) {},
                        isObscure: context.read<ProfileCubit>().confirmObscure,
                        suffixIcon: InkWell(
                          onTap: () => context
                              .read<ProfileCubit>()
                              .changeConfirmObscurePassword(),
                          child: Icon(
                              context.read<ProfileCubit>().confirmObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye,
                              color: AppColors.primary),
                        ),
                        validator: (value) {},
                        title: S.of(context).Confirm_Password,
                        hintText: S.of(context).Enter_confirmed_password,
                        prefix: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            passwordIcon,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CreateModel(
                          onError: (val) {
                            Dialogs.showSnackBar(
                                message: '$val',
                                typeSnackBar: AnimatedSnackBarType.error);
                          },
                          withValidation: true,
                          onTap: () {
                            return (Keys.formKey.currentState?.validate() ??
                                false);
                          },
                          onSuccess: (model) async {
                            Dialogs.showSnackBar(
                                message: S.of(context).password_successfully,
                                typeSnackBar: AnimatedSnackBarType.success);
                            Navigator.pop(context);
                          },
                          useCaseCallBack: (model) {
                            return null;
                          },
                          child: CustomButton(
                            text: S.of(context).Save,
                          )),
                      const SizedBox(
                        height: AppPaddingSize.padding_50,
                      )
                    ]),
                  ),
                ),
              ))),
    );
  }
}
