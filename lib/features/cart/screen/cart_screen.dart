import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_images/app_images.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/core/utils/functions/currency_formatter.dart';
import 'package:flutter_application_1/features/auth/screen/login_screen.dart';
import 'package:flutter_application_1/features/cart/cubit/cart_cubit.dart';
import 'package:flutter_application_1/features/cart/widget/cart_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constant/app_responsive/responsive.dart';
import '../../../core/ui/widgets/double_back.dart';
import '../../../generated/l10n.dart';
import '../../matrix/cubit/matrix_cubit.dart';
import '../../matrix/data/model/matrix.dart';
import '../../matrix/widget/matrix_card2.dart';
import '../../orders/screen/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double netAmount = 0;
    return BlocBuilder<MatrixCubit, MatrixState>(
      builder: (context, state) {
        return DoubleBackToClose(
          child: Scaffold(
            backgroundColor: AppColors.evenLighterBackground,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: BackWidget(
                existBack: false,
                title: S.of(context).Cart,
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CacheHelper.cartItem!.isEmpty ||
                              CacheHelper.cartItem == null
                          ? Column(
                              children: [
                                Image.asset(emptyCartImage),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      AppPaddingSize.padding_8),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      S.of(context).Cart_Empty,
                                      style: AppTextStyle.getBoldStyle(
                                          color: AppColors.black,
                                          fontSize: AppPaddingSize.padding_30),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: CacheHelper.cartItem?.length ?? 0,
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final matrixModel =
                                    CacheHelper.cartItem?[index];
                                context.read<CartCubit>().updateState();
                                if (matrixModel != null) {
                                  return CartCard(
                                    isDisscount: false,
                                    matrixModel: matrixModel,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                      Padding(
                        padding:
                            const EdgeInsets.all(AppPaddingSize.padding_10),
                        child: Text(
                          S.of(context).Products_might_like,
                          style: AppTextStyle.getBoldStyle(
                              color: AppColors.black,
                              fontSize: AppPaddingSize.padding_12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: 790,
                          child: PaginationList<MatrixModel>(
                            physics: const NeverScrollableScrollPhysics(),
                            withRefresh: false,
                            loadingHeight: 200.h,
                            withPagination: true,
                            onCubitCreated: (cubit) {
                              context.read<MatrixCubit>().matrixCubit = cubit;
                            },
                            repositoryCallBack: (data) {
                              if (data.skip == 0) {
                                data.take = 4;
                              }

                              return context
                                  .read<MatrixCubit>()
                                  .fetchMostSoldMatrix(data);
                            },
                            listBuilder: (list) => AutoHeightGridView(
                              itemCount: 4,
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              crossAxisCount:
                                  Responsive.isMobile(context) ? 2 : 3,
                              shrinkWrap: true,
                              crossAxisSpacing: AppPaddingSize.padding_26,
                              mainAxisSpacing: AppPaddingSize.padding_16,
                              physics: const NeverScrollableScrollPhysics(),
                              builder: (context, index) {
                                return MatrixCard2(
                                  height: 365,
                                  matrixModel: list[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: AppPaddingSize.padding_8),
                  child: Text(
                    S.of(context).cart_note,
                    style: AppTextStyle.getMediumStyle(
                        color: AppColors.black,
                        fontSize: AppPaddingSize.padding_14),
                  ),
                ),
                const Divider(
                  color: AppColors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        isEnabled: CacheHelper.cartItem!.isEmpty ? false : true,
                        onPressed: () {
                          if (CacheHelper.token == null) {
                            Navigation.push(const LoginScreen());
                          } else {
                            Navigation.push(CheckoutScreen(
                              subTotal: CacheHelper.cartItem!.fold<double>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue +
                                      ((element.productPrice?.addPrice1 ?? 0) *
                                              (element.quantity))
                                          .toInt()),
                            ));
                          }
                        },
                        h: 40.h,
                        w: 200.w,
                        text: S.of(context).Confirm,
                        radius: 50,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(AppPaddingSize.padding_10),
                        child: Row(
                          children: [
                            Text(
                              "(${CacheHelper.cartItem?.length ?? 0} Product)",
                              style: AppTextStyle.getMediumStyle(
                                color: AppColors.greyC1,
                                fontSize: AppPaddingSize.padding_8,
                              ),
                            ),
                            const SizedBox(
                              width: AppPaddingSize.padding_10,
                            ),
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                return Text(
                                  netAmount == 0
                                      ? CurrencyFormatter.formatCurrency(
                                          amount: CacheHelper.cartItem
                                                  ?.fold<double>(
                                                0.0,
                                                (previousValue, element) =>
                                                    previousValue +
                                                    ((element.productPrice
                                                                    ?.addPrice1 ??
                                                                0) *
                                                            (element.quantity))
                                                        .toDouble(),
                                              ) ??
                                              0.0,
                                          symbol: S.of(context).IQD,
                                        )
                                      : CurrencyFormatter.formatCurrency(
                                          amount: netAmount,
                                          symbol: S.of(context).IQD),
                                  style: AppTextStyle.getMediumStyle(
                                    color: AppColors.black,
                                    fontSize: AppPaddingSize.padding_12,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
