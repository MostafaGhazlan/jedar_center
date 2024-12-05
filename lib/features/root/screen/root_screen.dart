import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/screen/home_screen.dart';
import 'package:flutter_application_1/features/offer/screen/offer_screen.dart';
import 'package:flutter_application_1/features/cart/screen/cart_screen.dart';
import 'package:flutter_application_1/features/setting/screen/setting_screen.dart';
import 'package:flutter_application_1/features/shopping/screen/shopping_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../generated/l10n.dart';
import '../../wishlist/ui/wish_list_screen.dart';
import '../cubit/root_cubit.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, RootState>(
      builder: (context, state) {
        int currentIndex = context.read<RootCubit>().rootIndex;

        return Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: AppColors.pink,
            ),
            child: SizedBox(
              height: 78.h,
              child: BottomNavigationBar(
                elevation: 0,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: AppColors.pink,
                unselectedItemColor: AppColors.grey89,
                unselectedLabelStyle: AppTextStyle.getRegularStyle(
                    color: AppColors.grey89, fontSize: AppFontSize.size_12),
                selectedLabelStyle: AppTextStyle.getRegularStyle(
                    color: Theme.of(context).colorScheme.primaryColor,
                    fontSize: AppFontSize.size_12),
                currentIndex: currentIndex,
                onTap: (value) => context.read<RootCubit>().changePageIndex(value),
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    label: S.of(context).Home,
                    icon: SvgPicture.asset(
                      currentIndex == 0 ? selectHomeIcon : homeIcon,
                      fit: BoxFit.fill,
                      height: AppPaddingSize.padding_22,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: S.of(context).Offers,
                    icon: SvgPicture.asset(
                      currentIndex == 1 ? selectOfferIcon : offerIcon,
                      fit: BoxFit.fill,
                      height: AppPaddingSize.padding_22,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: S.of(context).My_Cart,
                    icon: SvgPicture.asset(
                      currentIndex == 2 ? selectCartIcon : cartIcon,
                      fit: BoxFit.fill,
                      height: AppPaddingSize.padding_22,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: S.of(context).Wishlist,
                    icon: SvgPicture.asset(
                      currentIndex == 3 ? selectWishlistIcon : wishlistIcon,
                      fit: BoxFit.fill,
                      height: AppPaddingSize.padding_22,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: S.of(context).Shopping,
                    icon: SvgPicture.asset(
                      currentIndex == 4 ? selectShoppingIcon : shoppingIcon,
                      fit: BoxFit.fill,
                      height: AppPaddingSize.padding_22,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: S.of(context).profile,
                    icon: SvgPicture.asset(
                       profileIcon,
                      fit: BoxFit.fill,
                      height: AppPaddingSize.padding_22,
                    ),
                  ),
                ],
              ),
            ),
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
