import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constant/app_padding/app_padding.dart';
import '../../../../../../core/constant/text_styles/app_text_style.dart';
import '../../../../../../core/constant/text_styles/font_size.dart';
import '../../../core/constant/app_colors/app_colors.dart';


class ProfileCard extends StatelessWidget {
  final double? widthIcon;
  final double? heightIcon ;
  final String title;
  final String iconUrl;
  final VoidCallback onTap;
  const ProfileCard({super.key, required this.title, required this.iconUrl, required this.onTap,  this.widthIcon, this.heightIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppPaddingSize.padding_25),
        child: Row(
           children: [
           SvgPicture.asset(
              iconUrl,
              width:widthIcon ,
              height: heightIcon,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: AppPaddingSize.padding_16,),
            Text(title,
            style:AppTextStyle.getRegularStyle(
                fontSize: AppFontSize.size_14,
                color: AppColors.black14) ,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded,color: AppColors.grey9A,)
          ],
        ),
      ),
    );
  }
}