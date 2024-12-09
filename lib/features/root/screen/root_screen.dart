import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../generated/l10n.dart';
import '../../wishlist/ui/wish_list_screen.dart';
import '../cubit/root_cubit.dart';
import 'package:flutter_application_1/features/home/screen/home_screen.dart';
import 'package:flutter_application_1/features/offer/screen/offer_screen.dart';
import 'package:flutter_application_1/features/cart/screen/cart_screen.dart';
import 'package:flutter_application_1/features/setting/screen/setting_screen.dart';
import 'package:flutter_application_1/features/shopping/screen/shopping_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, RootState>(
      builder: (context, state) {
        int currentIndex = context.read<RootCubit>().rootIndex;

        return Scaffold(
          bottomNavigationBar: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  backgroundRootImage,
                  fit: BoxFit.cover,
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: AppColors.primary,
                ),
                child: SizedBox(
                  height: 70,
                  child: BottomNavigationBar(
                    elevation: 0,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedItemColor: AppColors.white,
                    unselectedItemColor: AppColors.black,
                    unselectedLabelStyle: AppTextStyle.getRegularStyle(
                        color: AppColors.black, fontSize: AppFontSize.size_12),
                    selectedLabelStyle: AppTextStyle.getRegularStyle(
                        color: Theme.of(context).colorScheme.primaryColor,
                        fontSize: AppFontSize.size_12),
                    currentIndex: currentIndex,
                    onTap: (value) =>
                        context.read<RootCubit>().changePageIndex(value),
                    items: [
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        label: S.of(context).Home,
                        icon: SvgPicture.asset(
                          color: currentIndex == 0
                              ? AppColors.white
                              : AppColors.black,
                          currentIndex == 0 ? selectHomeIcon : homeIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: S.of(context).Offers,
                        icon: SvgPicture.asset(
                          color: currentIndex == 1
                              ? AppColors.white
                              : AppColors.black,
                          currentIndex == 1 ? selectOfferIcon : offerIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: S.of(context).My_Cart,
                        icon: SvgPicture.asset(
                          color: currentIndex == 2
                              ? AppColors.white
                              : AppColors.black,
                          currentIndex == 2 ? selectCartIcon : cartIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: S.of(context).Wishlist,
                        icon: SvgPicture.asset(
                          color: currentIndex == 3
                              ? AppColors.white
                              : AppColors.black,
                          currentIndex == 3 ? selectWishlistIcon : wishlistIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: S.of(context).Shopping,
                        icon: SvgPicture.asset(
                          color: currentIndex == 4
                              ? AppColors.white
                              : AppColors.black,
                          currentIndex == 4 ? selectShoppingIcon : shoppingIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: S.of(context).profile,
                        icon: SvgPicture.asset(
                          color: currentIndex == 5
                              ? AppColors.white
                              : AppColors.black,
                          profileIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: IndexedStack(
            index: currentIndex,
            children: const [
              HomeScreen(),
              OfferScreen(),
              CartScreen(),
              WishListScreen(),
              ShoppingScreen(),
              SettingScreen(),
            ],
          ),
        );
      },
    );
  }
}
