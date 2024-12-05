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
import '../../../generated/l10n.dart';
import '../cubit/matrix_cubit.dart';
import '../widget/matrix_card2.dart';

class MatrixScreen extends StatelessWidget {
  const MatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.evenLighterBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: BackWidget(
          existBack: false,
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  S.of(context).Welcome_Beautiful,
                  style: AppTextStyle.getMediumStyle(
                    color: AppColors.black,
                    fontSize: AppFontSize.size_20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PaginationList<MatrixModel>(
              loadingHeight: 200.h,
              withPagination: true,
              onCubitCreated: (cubit) {
                context.read<MatrixCubit>().matrixCubit = cubit;
              },
              repositoryCallBack: (data) {
                return context.read<MatrixCubit>().fetchMostSoldMatrix(data);
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
