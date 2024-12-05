import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/app_responsive/responsive.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/ui/widgets/cached_image.dart';
import '../../../generated/l10n.dart';
import '../../matrix/cubit/matrix_cubit.dart';
import '../../matrix/widget/matrix_card2.dart';

class MatrixByBrandScreen extends StatelessWidget {
  final String brandId;
  final String? color;
  final String? brandName;
  final String? brandLogo;
  const MatrixByBrandScreen(
      {super.key,
      required this.brandId,
      this.color,
      this.brandName,
      this.brandLogo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (() {
        try {
          return Color(int.parse('0xff${color!.substring(1)}'));
        } catch (e) {
          return AppColors.evenLighterBackground;
        }
      }()),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: color == null || color == "#ffffff"
              ? AppColors.black
              : Colors.white,
        ),
        title: BackWidget(
          endWidget: CachedImage(
            fit: BoxFit.fill,
            height: 40.h,
            imageUrl: brandLogo,
          ),
          existBack: false,
          titleWidget: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(
              brandName ?? S.of(context).Welcome_Beautiful,
              style: AppTextStyle.getMediumStyle(
                color: color == null || color == "#ffffff"
                    ? AppColors.black
                    : Colors.white,
                fontSize: AppFontSize.size_20,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PaginationList<MatrixModel>(
              loadingHeight: 200.h,
              baseColor: color == null || color == "#ffffff"
                  ? AppColors.pink
                  : Colors.white,
              highlightColor: color == null || color == "#ffffff"
                  ? AppColors.babyBlue
                  : Color(int.parse('0xff${color!.substring(1)}')),
              withPagination: true,
              onCubitCreated: (cubit) {
                context.read<MatrixCubit>().matrixCubit = cubit;
              },
              repositoryCallBack: (data) {
                return context
                    .read<MatrixCubit>()
                    .fetchMatrixByBrand(brandId, data);
              },
              listBuilder: (list) => AutoHeightGridView(
                itemCount: list.length,
                padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                shrinkWrap: true,
                crossAxisSpacing: AppPaddingSize.padding_26,
                mainAxisSpacing: AppPaddingSize.padding_16,
                physics: const BouncingScrollPhysics(),
                builder: (context, index) {
                  return MatrixCard2(
                    shadowColor: color == null || color == "#ffffff"
                        ? AppColors.black
                        : Colors.white,
                    shoppingButomColor: color == null || color == "#ffffff"
                        ? Colors.black
                        : Color(int.parse('0xff${color!.substring(1)}')),
                    discountContainerColor: color == null || color == "#ffffff"
                        ? const Color.fromARGB(127, 235, 164, 185)
                        : Color(int.parse('0xff${color!.substring(1)}')),
                    discountImageColor: color == null || color == "#ffffff"
                        ? AppColors.pink
                        : Color(int.parse('0xff${color!.substring(1)}')),
                    discountTextColor: color == null || color == "#ffffff"
                        ? Colors.red[900]
                        : AppColors.white,
                    matrixModel: list[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
