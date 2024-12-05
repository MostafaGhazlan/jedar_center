import 'package:flutter/material.dart';

import '../../../../../../core/constant/app_colors/app_colors.dart';
import '../../../../../../core/constant/app_padding/app_padding.dart';
import '../../../../../../core/constant/text_styles/app_text_style.dart';
import '../../../../../../core/constant/text_styles/font_size.dart';


class AdvantagesWidget extends StatelessWidget {
  final String title;
  final Color? descColor;
  final String description;
  final double? paddingBetween;
  final bool fromOrder;
  const AdvantagesWidget({super.key, required this.title, required this.description,  this.descColor,  this.paddingBetween,   this.fromOrder=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:fromOrder
                ? AppTextStyle.getMediumStyle(
                    color:AppColors.black14,
                    fontSize: AppFontSize.size_14)
                : AppTextStyle.getBoldStyle(
                    color:descColor??Theme.of(context).colorScheme.primaryColor,
                    fontSize: AppFontSize.size_16)),
        SizedBox(height: paddingBetween??AppPaddingSize.padding_16,),
        Text(description,
            style: AppTextStyle.getRegularStyle(
                color: AppColors.grey8E,
                fontSize: AppFontSize.size_12)),
      ],
    );
  }
}