import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/features/brand/widget/brand_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constant/app_images/app_images.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/end_points/api_url.dart';
import '../../../core/utils/Navigation/navigation.dart';
import '../../../generated/l10n.dart';
import '../cubit/brand_cubit.dart';
import '../data/model/brand.dart';
import 'matrix_by_brand_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.evenLighterBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: BackWidget(
          title: S.of(context).Brands,
          existBack: false,
        ),
      ),
      body: PaginationList<BrandModel>(
        loadingHeight: 200.h,
        withPagination: true,
        onCubitCreated: (cubit) {
          context.read<BrandCubit>().brandCubit = cubit;
        },
        repositoryCallBack: (data) {
          if (data.skip == 0) {
            data.take = 20;
          }
          if (data.skip >= 10) {
            data.skip += 10;
          }
          return context.read<BrandCubit>().fetchAllBrand(data);
        },
        listBuilder: (list) => AutoHeightGridView(
          itemCount: list.length,
          padding: const EdgeInsets.all(AppPaddingSize.padding_8),
          crossAxisCount: 3,
          shrinkWrap: true,
          crossAxisSpacing: AppPaddingSize.padding_26,
          mainAxisSpacing: AppPaddingSize.padding_16,
          physics: const BouncingScrollPhysics(),
          builder: (context, index) {
            final imageUrl = (list[index].document != null &&
                    list[index].document!.isNotEmpty &&
                    list[index].document!.first.filePath != null &&
                    list[index].document!.first.fileName != null)
                ? "$baseUrl${list[index].document!.first.filePath}/${list[index].document!.first.fileName}"
                : logoPngImage;
            return BrandCard(
              brandModel: list[index],
              onTap: () {
                Navigation.push(MatrixByBrandScreen(
                  color: list[index].colorCode,
                  brandLogo: imageUrl,
                  brandName: list[index].brandName,
                  brandId: list[index].id ?? "",
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
