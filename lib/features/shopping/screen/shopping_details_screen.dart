import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/core/ui/widgets/tab_widget.dart';
import 'package:flutter_application_1/features/matrix/widget/matrix_card2.dart';
import 'package:flutter_application_1/features/shopping/cubit/shopping_cubit.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/app_responsive/responsive.dart';
import '../../matrix/cubit/matrix_cubit.dart';
import '../../matrix/data/model/matrix.dart';

class ShoppingDetailsScreen extends StatelessWidget {
  final categoryId;
  final int initialIndex;
  const ShoppingDetailsScreen(
      {super.key, required this.categoryId, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.evenLighterBackground,
      body: GetModel<CategoryModel>(
        loadingHeight: 200.h,
        useCaseCallBack: () {
          return context
              .read<ShoppingCubit>()
              .fetchCategoryAndFamily(categoryId);
        },
        onError: (val) {
          debugPrint(val);
        },
        modelBuilder: (model) {
          int tabIndex =
              model.children?.indexWhere((child) => child.id == categoryId) ??
                  0;
          return Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              BackWidget(
                title: model.categoryName,
              ),
              if (model.children == null || model.children!.isEmpty)
                Expanded(
                  child: PaginationList<MatrixModel>(
                    loadingHeight: 200.h,
                    withPagination: true,
                    onCubitCreated: (cubit) {
                      context.read<MatrixCubit>().matrixCubit = cubit;
                    },
                    repositoryCallBack: (data) {
                      return context
                          .read<MatrixCubit>()
                          .fetchMatrixByCategory(categoryId, data);
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
                )
              else
                Expanded(
                  child: TabBarWidget(
                    isIndicatorColor: true,
                    initTab: tabIndex >= 0 ? tabIndex : 0,
                    tabLength: model.children?.length ?? 5,
                    screenTitleList: model.children
                            ?.map((child) => child.categoryName ?? "ssssss")
                            .toList() ??
                        [],
                    isScrollable: true,
                    screenList:
                        List.generate(model.children?.length ?? 5, (index) {
                      return PaginationList<MatrixModel>(
                        loadingHeight: 200.h,
                        withPagination: true,
                        onCubitCreated: (cubit) {
                          context.read<MatrixCubit>().matrixCubit = cubit;
                        },
                        repositoryCallBack: (data) {
                          return context
                              .read<MatrixCubit>()
                              .fetchMatrixByCategory(
                                  model.children?[index].id ?? 0, data);
                        },
                        listBuilder: (list) => AutoHeightGridView(
                          itemCount: list.length,
                          padding:
                              const EdgeInsets.all(AppPaddingSize.padding_8),
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
                      );
                    }),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
