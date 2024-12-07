import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
import 'package:flutter_application_1/core/ui/extination/app_extension.dart';
import 'package:flutter_application_1/features/matrix/cubit/matrix_cubit.dart';
import 'package:flutter_application_1/features/product/data/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/carousel_slider.dart';
import '../../../core/utils/functions/currency_formatter.dart';
import '../../../generated/l10n.dart';
import '../../home/cubit/cubit/home_cubit.dart';

class ProductCard extends StatelessWidget {
  final Function()? whenSuccess;
  final Function()? whenError;
  final ProductModel productModel;
  final bool isZoomable;

  const ProductCard({
    super.key,
    this.whenSuccess,
    this.isZoomable = false,
    this.whenError,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 200.w,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greyDD,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: AppColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CarouselWidget(
                  autoPlay: false,
                  isZoomable: isZoomable,
                  photoFit: BoxFit.contain,
                  images: productModel.documents!.map((doc) {
                    return '$baseUrl/${doc.filePath}/${doc.fileName}';
                  }).toList(),
                  controller: CarouselSliderController(),
                  onPageChanged: (index) =>
                      context.read<HomeCubit>().changeCarouselIndex(index),
                  currentIndexIndicator:
                      context.read<HomeCubit>().carouselIndex,
                  viewportFraction: 1,
                  padding: 2,
                  height: 135.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPaddingSize.padding_10),
                      child: BlocBuilder<MatrixCubit, MatrixState>(
                        builder: (context, state) {
                          bool isFavorite = CacheHelper.wishlist
                                  ?.any((item) => item.id == productModel.id) ??
                              false;
                          return LikeButton(
                            size: 25.r,
                            bubblesColor: const BubblesColor(
                                dotPrimaryColor: AppColors.primary,
                                dotSecondaryColor: AppColors.babyBlue),
                            circleColor: const CircleColor(
                                start: AppColors.babyBlue,
                                end: AppColors.primary),
                            countPostion: CountPostion.bottom,
                            isLiked: isFavorite,
                            onTap: (isLiked) async {
                              productModel.isFavorite =
                                  !productModel.isFavorite;
                              await context
                                  .read<MatrixCubit>()
                                  .changeFavorite(productModel);
                              return !isLiked;
                            },
                          );
                        },
                      ),
                    ),
                    productModel.discountItem != null
                        ? Padding(
                            padding:
                                const EdgeInsets.all(AppPaddingSize.padding_10),
                            child: BlocBuilder<MatrixCubit, MatrixState>(
                              builder: (context, state) {
                                return IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    color: AppColors.primary,
                                    discountImage,
                                    height: 25.r,
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {
                      try {
                        await CacheHelper.addToCart(productModel, true);
                        if (context.mounted) {
                          Dialogs.showSnackBar(
                              message: S.of(context).Product_added);
                          context.read<MatrixCubit>().zeroCounter();
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print(e.toString());
                        }
                      }
                    },
                    icon: Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: AppColors.evenLighterBackground,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: SvgPicture.asset(
                          shoppingBagImage,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    )),
                Row(
                  children: [
                    Text(
                      "(116)",
                      style: AppTextStyle.getMediumStyle(
                          color: AppColors.greyAD,
                          fontSize: AppPaddingSize.padding_12),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.evenLighterBackground,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: AppFontSize.size_1,
                                left: AppFontSize.size_1),
                            child: Text("4.9"),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: AppPaddingSize.padding_18,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppFontSize.size_8, right: AppFontSize.size_8),
              child: Text(
                productModel.brand?.brandName ?? "brand Name",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.getMediumStyle(
                  color: AppColors.greyA4,
                  fontSize: AppFontSize.size_12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppFontSize.size_4,
                right: AppFontSize.size_4,
              ),
              child: Text(
                productModel.productName ?? "Product Name",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.getMediumStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.size_12,
                ),
              ),
            ),
            productModel.discountItem == null
                ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppPaddingSize.padding_8,
                        left: AppPaddingSize.padding_8,
                        right: AppFontSize.size_8),
                    child: Text(
                      CurrencyFormatter.formatCurrency(
                        amount: double.tryParse(
                                (productModel.productPrice?.addPrice1 ??
                                        "25000")
                                    .toString()) ??
                            25000.0,
                        symbol: S.of(context).IQD,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.getSemiBoldStyle(
                        color: Colors.red[900]!,
                        fontSize: AppFontSize.size_12,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: AppPaddingSize.padding_8,
                        left: AppFontSize.size_8,
                        right: AppFontSize.size_8),
                    child: Text(
                      CurrencyFormatter.formatCurrency(
                        amount: double.tryParse(
                                (productModel.productPrice?.addPrice1 ??
                                        "25000")
                                    .toString()) ??
                            25000.0,
                        symbol: S.of(context).IQD,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.getSemiBoldStyle(
                        color: AppColors.greyAD,
                        fontSize: AppFontSize.size_10,
                      ).copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
            productModel.discountItem == null
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      productModel.discountItem?.discountType == 2
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppPaddingSize.padding_8,
                                  left: AppPaddingSize.padding_8,
                                  right: AppFontSize.size_8),
                              child: Text(
                                CurrencyFormatter.formatCurrency(
                                  amount:
                                      (productModel.productPrice?.addPrice1 ??
                                              0) -
                                          (productModel.discountItem
                                                  ?.discountValue ??
                                              0),
                                  symbol: S.of(context).IQD,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.getSemiBoldStyle(
                                  color: Colors.red[900]!,
                                  fontSize: AppFontSize.size_12,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppPaddingSize.padding_8,
                                left: AppPaddingSize.padding_8,
                                right: AppFontSize.size_8,
                              ),
                              child: Text(
                                CurrencyFormatter.formatCurrency(
                                  amount:
                                      (productModel.productPrice?.addPrice1 ??
                                              25000) *
                                          (1 -
                                              (productModel.discountItem
                                                          ?.discountValue ??
                                                      0) /
                                                  100),
                                  symbol: S.of(context).IQD,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.getSemiBoldStyle(
                                  color: Colors.red[900]!,
                                  fontSize: AppFontSize.size_12,
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppPaddingSize.padding_8,
                            left: AppPaddingSize.padding_8,
                            right: AppFontSize.size_8),
                        child: productModel.discountItem?.discountType == 1
                            ? Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        127, 235, 164, 185),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    CurrencyFormatter.formatCurrency(
                                      amount: double.tryParse((productModel
                                                  .discountItem?.discountValue)
                                              .toString()) ??
                                          25000.0,
                                      symbol: "%",
                                    ),
                                    style: AppTextStyle.getMediumStyle(
                                        color: Colors.red[900]!),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        127, 235, 164, 185),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    CurrencyFormatter.formatCurrency(
                                      amount: double.tryParse((productModel
                                                  .discountItem?.discountValue)
                                              .toString()) ??
                                          25000.0,
                                      symbol: S.of(context).IQD,
                                    ),
                                    style: AppTextStyle.getMediumStyle(
                                        color: Colors.red[900]!,
                                        fontSize: AppPaddingSize.padding_10),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
          ],
        ),
      ).fadeAnimation(0.5),
    );
  }
}
