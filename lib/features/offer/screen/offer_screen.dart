import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/ui/widgets/appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/app_responsive/responsive.dart';
import '../../../core/ui/widgets/double_back.dart';
import '../../matrix/cubit/matrix_cubit.dart';
import '../../matrix/data/model/matrix.dart';
import '../../matrix/widget/matrix_card2.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackToClose(
      child: Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: const AppBarWidget(),
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
                  return context.read<MatrixCubit>().fetchOffersMatrix(data);
                },
                listBuilder: (list) => AutoHeightGridView(
                  itemCount: list.length,
                  padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                  crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                  shrinkWrap: true,
                  crossAxisSpacing: AppPaddingSize.padding_6,
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
      ),
    );
  }
}
