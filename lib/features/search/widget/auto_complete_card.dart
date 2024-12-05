import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/features/search/data/model/auto_complete_model.dart';

class AutoCompleteCard extends StatelessWidget {
  final AutoCompleteModel autoCompleteModel;
  final void Function()? onTap;
  const AutoCompleteCard({super.key, required this.autoCompleteModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppPaddingSize.padding_20,
            right: AppPaddingSize.padding_20,
            top: AppPaddingSize.padding_20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  autoCompleteModel.name ?? "name",
                  style: AppTextStyle.getMediumStyle(color: AppColors.black),
                ),
                const Icon(Icons.arrow_outward_outlined)
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
