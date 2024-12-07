import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../generated/l10n.dart';
import '../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final Color? borderColor;
  final bool? existBack;
  final void Function()? onTap;
  final OrderModel? orderModel;
  const OrderCard(
      {super.key,
      this.orderModel,
      this.borderColor,
      this.onTap,
      this.existBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: borderColor ?? AppColors.greyDD)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPaddingSize.padding_10,
              vertical: AppPaddingSize.padding_14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),
                        const SizedBox(
                          width: AppPaddingSize.padding_10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderModel?.docStatusName ?? "docStatusName",
                              style: AppTextStyle.getBoldStyle(
                                  fontSize: AppFontSize.size_12,
                                  color:
                                      const Color.fromARGB(255, 83, 122, 206)),
                            ),
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              orderModel?.docDate ?? "docDate",
                              style: AppTextStyle.getBoldStyle(
                                  fontSize: AppFontSize.size_12,
                                  color: AppColors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  existBack == true
                      ? const Padding(
                          padding: EdgeInsets.all(AppPaddingSize.padding_10),
                          child: Icon(Icons.arrow_forward_ios),
                        )
                      : const SizedBox.shrink()
                ],
              ),
              const SizedBox(
                height: AppPaddingSize.padding_15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          offerIcon,
                          fit: BoxFit.fill,
                          height: AppPaddingSize.padding_22,
                        ),
                        const SizedBox(
                          width: AppPaddingSize.padding_10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).Order_Number,
                              style: AppTextStyle.getBoldStyle(
                                  fontSize: AppFontSize.size_12,
                                  color: AppColors.greyAD),
                            ),
                            Text(
                              orderModel?.docRef ?? "docRef",
                              style: AppTextStyle.getBoldStyle(
                                  fontSize: AppFontSize.size_12,
                                  color: AppColors.black14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPaddingSize.padding_10),
                    child: Row(
                      children: [
                        const Icon(Icons.price_change_outlined),
                        const SizedBox(
                          width: AppPaddingSize.padding_10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).Price,
                              style: AppTextStyle.getBoldStyle(
                                  fontSize: AppFontSize.size_12,
                                  color: AppColors.greyAD),
                            ),
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "${orderModel?.netAmount ?? "Net Amount"}",
                              style: AppTextStyle.getBoldStyle(
                                  fontSize: AppFontSize.size_12,
                                  color: AppColors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Icon(
                    Icons.location_pin,
                    color: AppColors.primary,
                  )),
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      CacheHelper.currentUserInfo?.name ?? "Name",
                      style: AppTextStyle.getBoldStyle(
                          fontSize: AppFontSize.size_12,
                          color: AppColors.black14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
