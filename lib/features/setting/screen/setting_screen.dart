import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/constant/text_styles/font_size.dart';
import 'package:flutter_application_1/core/ui/screens/splash_screen.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/auth/screen/login_screen.dart';
import 'package:flutter_application_1/features/root/cubit/root_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/ui/widgets/double_back.dart';
import '../../../generated/l10n.dart';
import '../../orders/screen/order_screen.dart';
import '../../profile/screens/change_lang.dart';
import '../../profile/screens/change_password_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackToClose(
      child: Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppPaddingSize.padding_70),
            Padding(
              padding: const EdgeInsets.all(AppPaddingSize.padding_10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context).welcome,
                  style: AppTextStyle.getBoldStyle(
                      color: AppColors.black, fontSize: AppFontSize.size_17),
                ),
              ),
            ),
            const SizedBox(height: AppPaddingSize.padding_30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CacheHelper.token != null
                        ? buildRow(Icons.store_mall_directory_outlined,
                            S.of(context).My_Orders, () {
                            Navigation.push(const OrderScreen());
                          })
                        : const SizedBox.shrink(),
                    CacheHelper.token != null
                        ? buildDivider()
                        : const SizedBox.shrink(),
                    CacheHelper.token != null
                        ? BlocBuilder<RootCubit, RootState>(
                            builder: (context, state) {
                              return buildRow(Icons.favorite_border_outlined,
                                  S.of(context).Favorite, () {
                                context.read<RootCubit>().changePageIndex(3);
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    CacheHelper.token != null
                        ? buildDivider()
                        : const SizedBox.shrink(),
                    CacheHelper.token != null
                        ? buildRow(
                            Icons.password_rounded,
                            S.of(context).Change_Password,
                            () => Navigation.push(const ChangePasswordScreen()))
                        : const SizedBox.shrink(),
                    CacheHelper.token != null
                        ? buildDivider()
                        : const SizedBox.shrink(),
                    buildRow(Icons.language, S.of(context).Change_Language,
                        () => Navigation.push(const ChangeLanguageScreen())),
                    buildDivider(),
                    buildRow(Icons.info_outline, S.of(context).About, () {}),
                    buildDivider(),
                    buildRow(Icons.contact_page_outlined,
                        S.of(context).Contact_Us, () {}),
                    buildDivider(),
                  ],
                ),
              ),
            ),
            CacheHelper.token == null
                ? Padding(
                    padding: const EdgeInsets.all(AppPaddingSize.padding_10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        onPressed: () {
                          Navigation.push(const LoginScreen());
                        },
                        text: S.of(context).SignIn,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(AppPaddingSize.padding_10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        onPressed: () async {
                          await CacheHelper.box.clear();
                          await CacheHelper.currentUserBox.clear();
                          await CacheHelper.cartBox.clear();
                          await CacheHelper.wishlistBox.clear();
                          Navigation.pushReplacement(const SplashScreen());
                        },
                        text: S.of(context).Logout,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget buildRow(IconData icon, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPaddingSize.padding_10),
              child: Icon(
                icon,
                size: AppPaddingSize.padding_20,
                color: AppColors.primary,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.getRegularStyle(
                    color: AppColors.black, fontSize: AppFontSize.size_15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: AppColors.primary,
      thickness: 1,
    );
  }
}
