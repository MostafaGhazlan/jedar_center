import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_images/app_images.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
import 'package:flutter_application_1/core/ui/extination/app_extension.dart';
import 'package:flutter_application_1/features/brand/data/model/brand.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/widgets/cached_image.dart';

class BrandCard extends StatelessWidget {
  final BrandModel brandModel;
  final void Function()? onTap;
  final Color? color;
  final BoxFit? fit;
  const BrandCard({super.key, required this.brandModel, this.color, this.fit, this.onTap,});

  @override
  Widget build(BuildContext context) {
    final imageUrl = (brandModel.document != null &&
            brandModel.document!.isNotEmpty &&
            brandModel.document!.first.filePath != null &&
            brandModel.document!.first.fileName != null)
        ? "$baseUrl${brandModel.document!.first.filePath}/${brandModel.document!.first.fileName}"
        : logoPngImage;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color ?? AppColors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.greyDD)),
        child: Padding(
          padding: const EdgeInsets.all(AppPaddingSize.padding_8),
          child: CachedImage(
            fit: fit ?? BoxFit.fill,
            imageUrl: imageUrl,
            width: 200.h,
          ).fadeAnimation(0.5),
        ),
      ),
    );
  }
}
