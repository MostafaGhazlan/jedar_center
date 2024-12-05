import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_images/app_images.dart';
import 'package:flutter_application_1/core/ui/widgets/action_alert_dialog.dart';
import 'package:flutter_application_1/core/ui/widgets/cached_image.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/product/data/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/end_points/api_url.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/utils/functions/currency_formatter.dart';
import '../../../generated/l10n.dart';
import '../../matrix/cubit/matrix_cubit.dart';
import '../../matrix/screen/matrix_details_screen.dart';

class CartCard extends StatelessWidget {
  final Function()? whenSuccess;
  final Function()? whenError;
  final bool isDisscount;
  final ProductModel matrixModel;

  const CartCard(
      {super.key,
      this.whenSuccess,
      this.whenError,
      required this.matrixModel,
      required this.isDisscount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixCubit, MatrixState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          Navigation.push(ProductDetailsScreen(
            model: context.read<MatrixCubit>().matrix!,
          ));
        },
        child: Card(
          color: AppColors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                child: CachedImage(
                  imageUrl: matrixModel.documents != null && matrixModel.documents!.isNotEmpty
                      ? "$baseUrl${matrixModel.documents!.first.filePath}/${matrixModel.documents!.first.fileName}"
                      : logoPngImage,

                  fit: BoxFit.contain,
                  height: 50.h,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                      child: Text(
                        matrixModel.brand?.brandName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.getBoldStyle(
                            color: AppColors.greyC1,
                            fontSize: AppPaddingSize.padding_8),
                      ),
                    ),
                    Row(

                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: AppPaddingSize.padding_10,
                                right: AppPaddingSize.padding_10,
                                bottom: AppPaddingSize.padding_10),
                            child: Text(
                              matrixModel.productName ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.getBoldStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppPaddingSize.padding_10,
                              right: AppPaddingSize.padding_10,
                              bottom: AppPaddingSize.padding_10),
                          child: IconButton(
                            onPressed: () {
                              ActionAlertDialog.show(context,
                                  dialogTitle:
                                      S.of(context).Confirm_deletion_title,
                                  message: S.of(context).Confirm_deletion,
                                  image:
                                      "$baseUrl${matrixModel.documents?.first.filePath}/${matrixModel.documents?.first.fileName}",
                                  onConfirm: () async {
                                await CacheHelper.cartBox.deleteAt(
                                  CacheHelper.cartBox.values
                                      .toList()
                                      .indexOf(matrixModel),
                                );
                                if (context.mounted) {
                                  context.read<MatrixCubit>().zeroCounter();
                                }
                                Navigation.pop();
                              },
                                  cancelText: S.of(context).Cancle,
                                  confirmText: S.of(context).Delete);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.red,
                              size: 10.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: matrixModel.discountItem == null
                              ? Padding(
                            padding: const EdgeInsets.only(
                                left: AppPaddingSize.padding_8,
                                right: AppPaddingSize.padding_8,
                                bottom: AppPaddingSize.padding_8),
                            child: Text(
                              CurrencyFormatter.formatCurrency(amount: (matrixModel.productPrice?.addPrice1! ?? 0) * matrixModel.quantity, symbol: S.of(context).IQD),
                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_10),
                            ),
                          )
                              : matrixModel.discountItem?.discountType == 2
                              ? Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppPaddingSize.padding_8,
                                left: AppPaddingSize.padding_8,
                                right: AppFontSize.size_8),
                            child: Text(
                              CurrencyFormatter.formatCurrency(
                                amount: (matrixModel.productPrice?.addPrice1 ?? 0) -
                                    (matrixModel.discountItem?.discountValue ?? 0),
                                symbol: S.of(context).IQD,
                              ),



                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_10),
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
                                amount: (matrixModel.productPrice?.addPrice1 ?? 25000) *
                                    (1 - (matrixModel.discountItem?.discountValue ?? 0) / 100),
                                symbol: S.of(context).IQD,
                              ),

                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.greyC1)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await CacheHelper.addToCart(matrixModel, true);
                                    if (context.mounted) {
                                      context.read<MatrixCubit>().zeroCounter();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 8.r,
                                  ),
                                ),
                                Text(
                                  "${matrixModel.quantity}",
                                  style: AppTextStyle.getBoldStyle(
                                      color: AppColors.black,
                                      fontSize: AppPaddingSize.padding_12),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (matrixModel.quantity > 0) {
                                      await CacheHelper.addToCart(matrixModel, false);

                                      if (context.mounted) {
                                        context.read<MatrixCubit>().zeroCounter();
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    size: 8.r,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
