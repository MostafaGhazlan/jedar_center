import 'package:flutter/material.dart';

import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';

class SettingRowWidget extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final String text;
  const SettingRowWidget(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppPaddingSize.padding_10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: AppPaddingSize.padding_20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppPaddingSize.padding_10),
                Expanded(
                  child: Text(
                    text,
                    style: AppTextStyle.getRegularStyle(
                        color: AppColors.black, fontSize: AppFontSize.size_15),
                  ),
                ),
              ],
            ),
            const Divider(
              color: AppColors.primary,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
