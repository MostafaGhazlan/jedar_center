import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/cached_image.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/ui/widgets/tab_widget.dart';
import 'package:flutter_application_1/features/matrix/cubit/matrix_cubit.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/product/cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/constant/app_images/app_images.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/end_points/api_url.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/carousel_slider.dart';
import '../../../core/utils/Navigation/navigation.dart';
import '../../../core/utils/functions/currency_formatter.dart';
import '../../../generated/l10n.dart';
import '../../brand/screen/matrix_by_brand_screen.dart';
import '../../home/cubit/cubit/home_cubit.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatelessWidget {
  final MatrixModel model;
  const ProductDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ProductCubit>().selectId = "";
        return true;
      },
      child: Scaffold(
          backgroundColor: AppColors.evenLighterBackground,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: Text(
                model.products![context.read<MatrixCubit>().selectedIndex].brand
                        ?.brandName ??
                    "",
                style: AppTextStyle.getBoldStyle(
                    color: AppColors.black, fontSize: AppFontSize.size_15),
              )),
          body: BlocBuilder<MatrixCubit, MatrixState>(
            builder: (context, state) {
              final imageUrl;
              if (model.products != null &&
                  model.products!.isNotEmpty &&
                  context.read<MatrixCubit>().selectedIndex <
                      model.products!.length &&
                  model.products![context.read<MatrixCubit>().selectedIndex]
                          .brand?.document !=
                      null &&
                  model.products![context.read<MatrixCubit>().selectedIndex]
                      .brand!.document!.isNotEmpty &&
                  model.products![context.read<MatrixCubit>().selectedIndex]
                          .brand!.document!.first.filePath !=
                      null &&
                  model.products![context.read<MatrixCubit>().selectedIndex]
                          .brand!.document!.first.fileName !=
                      null) {
                imageUrl =
                    "$baseUrl${model.products![context.read<MatrixCubit>().selectedIndex].brand!.document!.first.filePath}/${model.products![context.read<MatrixCubit>().selectedIndex].brand!.document!.first.fileName}";
              } else {
                imageUrl = logoPngImage;
              }

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: CarouselWidget(
                            isZoomable: true,
                            autoPlay: true,
                            photoFit: BoxFit.contain,
                            images: model
                                .products![
                                    context.read<MatrixCubit>().selectedIndex]
                                .documents!
                                .map((doc) {
                              return '$baseUrl/${doc.filePath}/${doc.fileName}';
                            }).toList(),
                            controller: CarouselSliderController(),
                            onPageChanged: (index) => context
                                .read<HomeCubit>()
                                .changeCarouselIndex(index),
                            currentIndexIndicator:
                                context.read<HomeCubit>().carouselIndex,
                            viewportFraction: 1,
                            padding: 2,
                            height: 200.h,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigation.push(MatrixByBrandScreen(
                                  color: model
                                      .products![context
                                          .read<MatrixCubit>()
                                          .selectedIndex]
                                      .brand
                                      ?.colorCode,
                                  brandId: model
                                          .products![context
                                              .read<MatrixCubit>()
                                              .selectedIndex]
                                          .brand
                                          ?.id ??
                                      "",
                                  brandName: model
                                      .products![context
                                          .read<MatrixCubit>()
                                          .selectedIndex]
                                      .brand
                                      ?.brandName,
                                  brandLogo: imageUrl,
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedImage(
                                      height: 50.h,
                                      width: 50.w,
                                      imageUrl: imageUrl,
                                    ),
                                    Text(
                                      model
                                              .products![context
                                                  .read<MatrixCubit>()
                                                  .selectedIndex]
                                              .brand
                                              ?.brandName ??
                                          "",
                                      style: AppTextStyle.getMediumStyle(
                                          color: AppColors.pink),
                                    ),
                                    Text(
                                      S.of(context).click_here,
                                      style: AppTextStyle.getMediumStyle(
                                          color: AppColors.blueFace),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppPaddingSize.padding_8),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Share.share(
                                          'check out my website https://example.com');
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      size: 15.r,
                                    ),
                                  ),
                                  BlocBuilder<MatrixCubit, MatrixState>(
                                    builder: (context, state) {
                                      var selectedProduct = model.products?[
                                          context
                                              .read<MatrixCubit>()
                                              .selectedIndex];

                                      bool isFavorite = CacheHelper.wishlist
                                              ?.any((item) =>
                                                  item.id ==
                                                  selectedProduct?.id) ??
                                          false;

                                      return LikeButton(
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: AppColors.pink,
                                            dotSecondaryColor:
                                                AppColors.babyBlue),
                                        circleColor: const CircleColor(
                                            start: AppColors.babyBlue,
                                            end: AppColors.pink),
                                        size: 15.r,
                                        countPostion: CountPostion.bottom,
                                        isLiked: isFavorite,
                                        onTap: (isLiked) async {
                                          if (selectedProduct != null) {
                                            selectedProduct.isFavorite =
                                                !selectedProduct.isFavorite;
                                            await context
                                                .read<MatrixCubit>()
                                                .changeFavorite(
                                                    selectedProduct);
                                            return !isLiked;
                                          }
                                          return isLiked;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.greyE5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: AppPaddingSize.padding_10,
                            left: AppPaddingSize.padding_10,
                          ),
                          child: Text(
                            S.of(context).Original,
                            style: AppTextStyle.getMediumStyle(
                                color: AppColors.green,
                                fontSize: AppPaddingSize.padding_15),
                          ),
                        ),
                        const Divider(
                          color: AppColors.greyE5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: AppPaddingSize.padding_10,
                              left: AppPaddingSize.padding_10,
                              top: AppPaddingSize.padding_20),
                          child: Text(
                            model
                                    .products![context
                                        .read<MatrixCubit>()
                                        .selectedIndex]
                                    .productName ??
                                S.of(context).description,
                            style: AppTextStyle.getMediumStyle(
                                color: AppColors.black,
                                fontSize: AppPaddingSize.padding_18),
                          ),
                        ),
                        const SizedBox(
                          height: AppPaddingSize.padding_10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              "5/5",
                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_18),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            const Text("(47 Review)"),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: AppPaddingSize.padding_10,
                                left: AppPaddingSize.padding_10,
                                top: AppPaddingSize.padding_20),
                            child: Text(
                              S.of(context).Colors,
                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_18),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              model.products!.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  context
                                      .read<MatrixCubit>()
                                      .changeIndexDetails(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      AppPaddingSize.padding_8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: context
                                                  .read<MatrixCubit>()
                                                  .selectedIndex ==
                                              index
                                          ? Border.all(
                                              color: AppColors.pink, width: 1.5)
                                          : null,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        radius: 15.h,
                                        backgroundColor: (() {
                                          try {
                                            return Color(int.parse(
                                                '0xff${model.products?[index].hexColorCode!.substring(1)}'));
                                          } catch (e) {
                                            return Colors.white;
                                          }
                                        }()),
                                        child: const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        model
                                    .products?[context
                                        .read<MatrixCubit>()
                                        .selectedIndex]
                                    .productSize !=
                                null
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: AppPaddingSize.padding_10,
                                      left: AppPaddingSize.padding_10,
                                      top: AppPaddingSize.padding_20),
                                  child: Text(
                                    "Size :",
                                    style: AppTextStyle.getMediumStyle(
                                        color: AppColors.black,
                                        fontSize: AppPaddingSize.padding_18),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Row(
                          children:
                              List.generate(model.products!.length, (index) {
                            if (model.products?[index].productSize == null) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: CircleAvatar(
                                radius: 18.h,
                                backgroundColor: AppColors.greyDD,
                                child: Text(
                                    model.products?[index].productSize ??
                                        "Size"),
                              ),
                            );
                          }),
                        ),
                        const Divider(
                          color: AppColors.greyE5,
                        ),
                        model
                                    .products![context
                                        .read<MatrixCubit>()
                                        .selectedIndex]
                                    .discountItem ==
                                null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppPaddingSize.padding_8,
                                    left: AppPaddingSize.padding_8,
                                    right: AppFontSize.size_8),
                                child: Text(
                                  CurrencyFormatter.formatCurrency(
                                    amount: double.tryParse((model.products![0]
                                                    .productPrice?.addPrice1 ??
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
                                    fontSize: AppFontSize.size_16,
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
                                    amount: double.tryParse((model.products![0]
                                                    .productPrice?.addPrice1 ??
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
                                    fontSize: AppFontSize.size_14,
                                  ).copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                        model
                                    .products![context
                                        .read<MatrixCubit>()
                                        .selectedIndex]
                                    .discountItem ==
                                null
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  model.products?[0].discountItem
                                              ?.discountType ==
                                          2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: AppPaddingSize.padding_8,
                                              left: AppPaddingSize.padding_8,
                                              right: AppFontSize.size_8),
                                          child: Text(
                                            CurrencyFormatter.formatCurrency(
                                              amount: (model
                                                          .products?[0]
                                                          .productPrice
                                                          ?.addPrice1 ??
                                                      0) -
                                                  (model
                                                          .products?[0]
                                                          .discountItem
                                                          ?.discountValue ??
                                                      0),
                                              symbol: S.of(context).IQD,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                AppTextStyle.getSemiBoldStyle(
                                              color: Colors.red[900]!,
                                              fontSize: AppFontSize.size_16,
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
                                              amount: (model
                                                          .products?[0]
                                                          .productPrice
                                                          ?.addPrice1 ??
                                                      25000) *
                                                  (1 -
                                                      (model
                                                                  .products?[0]
                                                                  .discountItem
                                                                  ?.discountValue ??
                                                              0) /
                                                          100),
                                              symbol: S.of(context).IQD,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                AppTextStyle.getSemiBoldStyle(
                                              color: Colors.red[900]!,
                                              fontSize: AppFontSize.size_16,
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: AppPaddingSize.padding_8,
                                        left: AppPaddingSize.padding_8,
                                        right: AppFontSize.size_8),
                                    child: model.products?[0].discountItem
                                                ?.discountType ==
                                            1
                                        ? Container(
                                            height: 20.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    127, 235, 164, 185),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                                child: Text(
                                              CurrencyFormatter.formatCurrency(
                                                amount: double.tryParse((model
                                                            .products?[0]
                                                            .discountItem
                                                            ?.discountValue)
                                                        .toString()) ??
                                                    25000.0,
                                                symbol: "%",
                                              ),
                                              style:
                                                  AppTextStyle.getMediumStyle(
                                                      color: Colors.red[900]!),
                                            )),
                                          )
                                        : Container(
                                            height: 20.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    127, 235, 164, 185),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                                child: Text(
                                              CurrencyFormatter.formatCurrency(
                                                amount: double.tryParse((model
                                                            .products?[0]
                                                            .discountItem
                                                            ?.discountValue)
                                                        .toString()) ??
                                                    25000.0,
                                                symbol: S.of(context).IQD,
                                              ),
                                              style:
                                                  AppTextStyle.getMediumStyle(
                                                      color: Colors.red[900]!),
                                              textAlign: TextAlign.center,
                                            )),
                                          ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 200.h,
                          child: TabBarWidget(
                              tabLength: 3,
                              screenList: List.generate(3, (index) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            AppPaddingSize.padding_8),
                                        child: Text(
                                          model
                                                  .products![context
                                                      .read<MatrixCubit>()
                                                      .selectedIndex]
                                                  .description ??
                                              "",
                                          style: AppTextStyle.getMediumStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              screenTitleList: [
                                S.of(context).description,
                                S.of(context).how_use_it,
                                S.of(context).specifications
                              ],
                              isScrollable: true,
                              isIndicatorColor: true),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        onPressed: () async {
                          try {
                            await CacheHelper.addToCart(
                                model.products![
                                    context.read<MatrixCubit>().selectedIndex],
                                true);
                            if (context.mounted) {
                              Dialogs.showSnackBar(
                                  message: S.of(context).Product_added);
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e.toString());
                            }
                          }
                        },
                        text: S.of(context).Add_To_Cart,
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
