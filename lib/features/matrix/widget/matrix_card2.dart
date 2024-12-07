import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
import 'package:flutter_application_1/core/ui/extination/app_extension.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/matrix/cubit/matrix_cubit.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
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
import '../screen/matrix_details_screen.dart';

class MatrixCard2 extends StatelessWidget {
  final MatrixModel matrixModel;
  final bool isZoomable;
  final Color? shadowColor;
  final Color? shoppingButomColor;
  final Color? discountContainerColor;
  final Color? discountTextColor;
  final Color? discountImageColor;
  final double? height;

  const MatrixCard2({
    super.key,
    this.isZoomable = false,
    required this.matrixModel,
    this.shadowColor,
    this.shoppingButomColor,
    this.discountContainerColor,
    this.discountTextColor,
    this.discountImageColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async {
        Navigation.push(
          ProductDetailsScreen(
            model: matrixModel,
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 200.w,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: shadowColor?.withOpacity(0.2) ??
                    Colors.black.withOpacity(0.2),
                offset: const Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
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
                  images: ["$baseUrl${matrixModel.imageName}"],
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
                    matrixModel.products?.length == 1
                        ? Padding(
                            padding:
                                const EdgeInsets.all(AppPaddingSize.padding_10),
                            child: BlocBuilder<MatrixCubit, MatrixState>(
                              builder: (context, state) {
                                bool isFavorite = CacheHelper.wishlist?.any(
                                        (item) =>
                                            item.id ==
                                            matrixModel.products?.first.id) ??
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
                                    if (matrixModel.products != null) {
                                      matrixModel.products?.first.isFavorite =
                                          !matrixModel
                                              .products!.first.isFavorite;
                                      await context
                                          .read<MatrixCubit>()
                                          .changeFavorite(
                                              matrixModel.products!.first);
                                      return !isLiked;
                                    }
                                    return isLiked;
                                  },
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    (matrixModel.products != null &&
                            matrixModel.products!.isNotEmpty &&
                            matrixModel.products![0].discountItem != null)
                        ? Padding(
                            padding:
                                const EdgeInsets.all(AppPaddingSize.padding_10),
                            child: BlocBuilder<MatrixCubit, MatrixState>(
                              builder: (context, state) {
                                return IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    color:
                                        discountImageColor ?? AppColors.primary,
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
                matrixModel.products?.length == 1
                    ? IconButton(
                        onPressed: () async {
                          try {
                            await CacheHelper.addToCart(
                                matrixModel.products!.first, true);
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
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              color: AppColors.evenLighterBackground,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: SvgPicture.asset(
                              color: shoppingButomColor ?? AppColors.black,
                              shoppingBagImage,
                              height: 25.h,
                              width: 25.w,
                            ),
                          ),
                        ))
                    : IconButton(
                        onPressed: () async {
                          Navigation.push(
                            ProductDetailsScreen(
                              model: matrixModel,
                            ),
                          );
                        },
                        icon: Container(
                          height: 25.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                              color: AppColors.evenLighterBackground,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: SvgPicture.asset(
                              multipleImage,
                              height: 15.h,
                              width: 15.w,
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
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppFontSize.size_8, right: AppFontSize.size_8),
              child: Text(
                (matrixModel.products != null &&
                        matrixModel.products!.isNotEmpty)
                    ? (matrixModel.products![0].brand?.brandName ??
                        "brand Name")
                    : "brand Name",
                maxLines: 3,
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
                (matrixModel.products != null &&
                        matrixModel.products!.isNotEmpty)
                    ? (matrixModel.products![0].productName ?? "Product Name")
                    : "Product Name",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.getMediumStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.size_12,
                ),
              ),
            ),
            (matrixModel.products != null &&
                    matrixModel.products!.isNotEmpty &&
                    matrixModel.products![0].discountItem == null)
                ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppPaddingSize.padding_8,
                        left: AppPaddingSize.padding_8,
                        right: AppFontSize.size_8),
                    child: Text(
                      CurrencyFormatter.formatCurrency(
                        amount: (matrixModel.products != null &&
                                matrixModel.products!.isNotEmpty)
                            ? double.tryParse((matrixModel.products![0]
                                            .productPrice?.addPrice1 ??
                                        "25000")
                                    .toString()) ??
                                25000.0
                            : 25000.0,
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
                        amount: (matrixModel.products != null &&
                                matrixModel.products!.isNotEmpty)
                            ? double.tryParse((matrixModel.products![0]
                                            .productPrice?.addPrice1 ??
                                        "25000")
                                    .toString()) ??
                                25000.0
                            : 25000.0,
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
            (matrixModel.products != null &&
                    matrixModel.products!.isNotEmpty &&
                    matrixModel.products![0].discountItem == null)
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (matrixModel.products != null &&
                              matrixModel.products!.isNotEmpty)
                          ? (matrixModel.products![0].discountItem
                                      ?.discountType ==
                                  2
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppPaddingSize.padding_8,
                                    left: AppPaddingSize.padding_8,
                                    right: AppFontSize.size_8,
                                  ),
                                  child: Text(
                                    CurrencyFormatter.formatCurrency(
                                      amount: (matrixModel.products![0]
                                                  .productPrice?.addPrice1 ??
                                              0) -
                                          (matrixModel.products![0].discountItem
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
                                      amount: (matrixModel.products![0]
                                                  .productPrice?.addPrice1 ??
                                              25000) *
                                          (1 -
                                              (matrixModel
                                                          .products![0]
                                                          .discountItem
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
                                ))
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppPaddingSize.padding_8,
                          left: AppPaddingSize.padding_8,
                          right: AppFontSize.size_8,
                        ),
                        child: (matrixModel.products != null &&
                                matrixModel.products!.isNotEmpty &&
                                matrixModel.products![0].discountItem
                                        ?.discountType ==
                                    1)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: discountContainerColor ??
                                      const Color.fromARGB(127, 235, 164, 185),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    CurrencyFormatter.formatCurrency(
                                      amount: double.tryParse((matrixModel
                                                  .products![0]
                                                  .discountItem
                                                  ?.discountValue)
                                              .toString()) ??
                                          25000.0,
                                      symbol: "%",
                                    ),
                                    style: AppTextStyle.getMediumStyle(
                                      color:
                                          discountTextColor ?? Colors.red[900]!,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: discountContainerColor ??
                                      const Color.fromARGB(127, 235, 164, 185),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    CurrencyFormatter.formatCurrency(
                                      amount: (matrixModel.products != null &&
                                              matrixModel
                                                  .products!.isNotEmpty &&
                                              matrixModel.products![0]
                                                      .discountItem !=
                                                  null)
                                          ? double.tryParse((matrixModel
                                                      .products![0]
                                                      .discountItem
                                                      ?.discountValue)
                                                  .toString()) ??
                                              25000.0
                                          : 25000.0,
                                      symbol: S.of(context).IQD,
                                    ),
                                    style: AppTextStyle.getMediumStyle(
                                      color:
                                          discountTextColor ?? Colors.red[900]!,
                                      fontSize: AppPaddingSize.padding_10,
                                    ),
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
