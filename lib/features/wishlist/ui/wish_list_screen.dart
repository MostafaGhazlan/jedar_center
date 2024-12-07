import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_responsive/responsive.dart';
import 'package:flutter_application_1/features/matrix/cubit/matrix_cubit.dart';
import 'package:flutter_application_1/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/constant/app_images/app_images.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/double_back.dart';
import '../../../generated/l10n.dart';
import '../../product/widget/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return DoubleBackToClose(
      child: BlocBuilder<MatrixCubit, MatrixState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.evenLighterBackground,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: BackWidget(
                        existBack: false,
                        title: S.of(context).My_WishList,
                      )),
                      CustomButton(
                        onPressed: () async {
                          await context
                              .read<WishlistCubit>()
                              .clearAllWishlist();
                        },
                        w: 126,
                        h: 30,
                        text: S.of(context).remove,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<WishlistCubit, WishlistState>(
                    listener: (context, state) {
                      if (state is WishlistLoading) {
                        Container(
                          alignment: Alignment.center,
                          color: Colors.white30,
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: SizedBox(
                              width: 200.w,
                              height: 100.h,
                              child: Shimmer.fromColors(
                                baseColor: AppColors.primary,
                                highlightColor: AppColors.babyBlue,
                                child: Image.asset(logoPngImage),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Expanded(
                        child: Stack(
                          children: [
                            AutoHeightGridView(
                              itemCount: CacheHelper.wishlist?.length ?? 0,
                              padding: const EdgeInsets.all(0),
                              crossAxisCount:
                                  Responsive.isMobile(context) ? 2 : 3,
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 5,
                              physics: const BouncingScrollPhysics(),
                              builder: (context, index) {
                                final productModel =
                                    CacheHelper.wishlist?[index];
                                if (productModel != null) {
                                  return ProductCard(
                                    productModel: productModel,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            if (state is WishlistLoading)
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white30,
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(
                                  child: SizedBox(
                                    width: 200.w,
                                    height: 100.h,
                                    child: Shimmer.fromColors(
                                      baseColor: AppColors.primary,
                                      highlightColor: AppColors.babyBlue,
                                      child: Image.asset(logoPngImage),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
