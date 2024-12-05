import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';

class OfferCard extends StatelessWidget {
  final Color? color;
  const OfferCard({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79.h,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
              padding: const EdgeInsets.all(AppPaddingSize.padding_8),
              child: Icon(
                Icons.face,
                size: 35.h,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "فاونديشن",
                style: AppTextStyle.getBoldStyle(
                    color: AppColors.black, fontSize: AppFontSize.size_18),
              ),
              Text(
                "Foundation",
                style: AppTextStyle.getBoldStyle(
                    color: AppColors.white, fontSize: AppFontSize.size_18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
