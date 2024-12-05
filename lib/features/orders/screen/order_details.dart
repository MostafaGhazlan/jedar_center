import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/cached_image.dart';
import 'package:flutter_application_1/features/orders/cubit/order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/ui/widgets/back_widget.dart';
import '../../../generated/l10n.dart';
import '../data/models/order_model.dart';
import '../widget/order_card.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDetails({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.evenLighterBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddingSize.padding_16,
        ),
        child: ListView(
          children: [
            SizedBox(height: 50.h),
            const BackWidget(
              title: "Order Details",
            ),
            const SizedBox(
              height: AppPaddingSize.padding_20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPaddingSize.padding_12),
              child: OrderCard(
                  orderModel: orderModel, borderColor: Colors.transparent),
            ),
            GetModel<OrderModel>(
              loadingHeight: 200.h,
              useCaseCallBack: () {
                return context
                    .read<OrderCubit>()
                    .getOneOrdersOrder(orderModel.id);
              },
              modelBuilder: (model) {
                context.read<OrderCubit>().updateTotals(model);

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.details?.length ?? 0,
                  itemBuilder: (context, index) {
                    final detail = model.details![index];
                    final product = detail.product;

                    return Card(
                      color: AppColors.white,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: AppPaddingSize.padding_8),
                      child: ListTile(
                        leading: product?.documents != null &&
                                product!.documents!.isNotEmpty
                            ? CachedImage(
                                width: 50.w,
                                height: 50.h,
                                imageUrl:
                                    "$baseUrl${product.documents![0].filePath}/${product.documents![0].fileName}",
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(
                          product?.productName ?? "Unknown Product",
                          style: AppTextStyle.getMediumStyle(
                              color: AppColors.black,
                              fontSize: AppPaddingSize.padding_10.sp),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${S.of(context).Color}: ${product?.productColor ?? "N/A"}",
                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.greyC1,
                                  fontSize: AppPaddingSize.padding_8.sp),
                            ),
                            Text(
                              "${S.of(context).Price}: ${detail.price} ${S.of(context).IQD}",
                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.black,
                                  fontSize: AppPaddingSize.padding_10.sp),
                            ),
                          ],
                        ),
                        trailing: Container(
                          width: 20.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: AppColors.lighterBackground,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "${detail.qty?.toInt()}",
                              style: AppTextStyle.getMediumStyle(
                                  color: AppColors.greyA9,
                                  fontSize: AppPaddingSize.padding_8.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const SizedBox.shrink();
                }
                return Card(
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                S.of(context).Subtotal,
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.greyA4,
                                    fontSize: AppPaddingSize.padding_15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                S.of(context).Delivery_Charges,
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.greyA4,
                                    fontSize: AppPaddingSize.padding_15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                S.of(context).Service_Fees,
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.greyA4,
                                    fontSize: AppPaddingSize.padding_15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                S.of(context).Total_Amount,
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.black,
                                    fontSize: AppPaddingSize.padding_17),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                "${context.watch<OrderCubit>().subTotal.toString()} ${S.of(context).IQD}",
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.greyA4,
                                    fontSize: AppPaddingSize.padding_15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                "0 ${S.of(context).IQD}",
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.greyA4,
                                    fontSize: AppPaddingSize.padding_15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                "0 ${S.of(context).IQD}",
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.greyA4,
                                    fontSize: AppPaddingSize.padding_15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                "${context.watch<OrderCubit>().total} ${S.of(context).IQD}",
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.black,
                                    fontSize: AppPaddingSize.padding_17),
                              ),
                            ),
                          ],
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
  }
}
