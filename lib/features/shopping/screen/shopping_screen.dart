import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:flutter_application_1/core/constant/app_images/app_images.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/appbar_widget.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/shopping/cubit/shopping_cubit.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import 'package:flutter_application_1/features/shopping/screen/shopping_details_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/end_points/api_url.dart';
import '../../../core/ui/widgets/cached_image.dart';
import '../../../core/ui/widgets/double_back.dart';
import '../../../generated/l10n.dart';
import '../../brand/cubit/brand_cubit.dart';
import '../../brand/data/model/brand.dart';
import '../../brand/screen/matrix_by_brand_screen.dart';
import '../../brand/widget/brand_card.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackToClose(
      child: Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: const AppBarWidget(),
        ),
        body: PaginationList<CategoryModel>(
            loadingHeight: 200.h,
            withPagination: false,
            onCubitCreated: (cubit) {
              context.read<ShoppingCubit>().categoryCubit = cubit;
            },
            repositoryCallBack: (data) {
              return context.read<ShoppingCubit>().fetchAllCategory(data);
            },
            listBuilder: (list) {
              context.read<ShoppingCubit>().selectedIndex = list[0];
              context.read<BrandCubit>().selectedCategoryId = list[0].id;

              return Row(
                children: [
                  Container(
                    color: AppColors.evenLighterBackground,
                    width: 70.w,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return BlocBuilder<ShoppingCubit, ShoppingState>(
                            builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              if (list[index].children!.isEmpty ||
                                  list[index].children == null) {
                                Navigation.push(ShoppingDetailsScreen(
                                  initialIndex: index,
                                  categoryId: list[index].id,
                                ));
                              }
                              context
                                  .read<ShoppingCubit>()
                                  .selectCategory(list[index]);
                              context.read<BrandCubit>().selectedCategoryId =
                                  list[index].id;
                              context.read<BrandCubit>().fetchMatrixByCategory(
                                  context.read<BrandCubit>().selectedCategoryId,
                                  GetListRequest(skip: 0, take: 6));
                              context.read<BrandCubit>().brandCubit?.getList();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 65.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyDD,
                                      width: 0.8.w,
                                    ),
                                    color: context
                                                .read<ShoppingCubit>()
                                                .selectedIndex ==
                                            list[index]
                                        ? AppColors.white
                                        : AppColors.evenLighterBackground,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CachedImage(
                                          fit: BoxFit.contain,
                                          imageUrl: (list[index].documents !=
                                                      null &&
                                                  list[index]
                                                      .documents!
                                                      .isNotEmpty)
                                              ? "$baseUrl${list[index].documents!.first.filePath}/${list[index].documents!.first.fileName}"
                                              : logoPngImage,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppPaddingSize.padding_5,
                                      ),
                                      Text(
                                        maxLines: 2,
                                        list[index].categoryName ?? "Makeup",
                                        style: AppTextStyle.getRegularStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_10),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  width: 3,
                                  height: context
                                              .read<ShoppingCubit>()
                                              .selectedIndex ==
                                          list[index]
                                      ? 48.h
                                      : 0.h,
                                  color: AppColors.pink,
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(AppPaddingSize.padding_8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0),
                              child: Image.asset(
                                makeupImages[6],
                                fit: BoxFit.cover,
                                height: 60.h,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          BlocBuilder<ShoppingCubit, ShoppingState>(
                            builder: (context, state) {
                              return Card(
                                color: AppColors.white,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    var categoriesWithNoChildren = context
                                            .read<ShoppingCubit>()
                                            .selectedIndex
                                            ?.children
                                            ?.where((category) =>
                                                category.children == null ||
                                                category.children!.isEmpty)
                                            .toList() ??
                                        [];

                                    var categoriesWithChildren = context
                                            .read<ShoppingCubit>()
                                            .selectedIndex
                                            ?.children
                                            ?.where((category) =>
                                                category.children != null &&
                                                category.children!.isNotEmpty)
                                            .toList() ??
                                        [];

                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0.0,
                                            mainAxisSpacing: 3.0,
                                          ),
                                          itemCount:
                                              categoriesWithNoChildren.length,
                                          itemBuilder: (context, gridIndex) {
                                            var category =
                                                categoriesWithNoChildren[
                                                    gridIndex];

                                            return Column(
                                              children: [
                                                Container(
                                                  height: 50.h,
                                                  width: 65.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors.greyE5,
                                                      width: 0.8.w,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AppColors.white,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      int initialIndex =
                                                          categoriesWithNoChildren
                                                              .indexWhere(
                                                                  (cat) =>
                                                                      cat.id ==
                                                                      category
                                                                          .id);

                                                      Navigation.push(
                                                          ShoppingDetailsScreen(
                                                              initialIndex:
                                                                  initialIndex >=
                                                                          0
                                                                      ? initialIndex
                                                                      : 0,
                                                              categoryId:
                                                                  category.id));
                                                    },
                                                    child: Center(
                                                      child: CachedImage(
                                                        height: 40.h,
                                                        fit: BoxFit.scaleDown,
                                                        imageUrl: (category
                                                                        .documents !=
                                                                    null &&
                                                                category
                                                                    .documents!
                                                                    .isNotEmpty)
                                                            ? "$baseUrl${category.documents!.first.filePath}/${category.documents!.first.fileName}"
                                                            : logoPngImage,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  category.categoryName ?? "",
                                                  style: AppTextStyle
                                                      .getRegularStyle(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: AppPaddingSize.padding_12,
                                                right:
                                                    AppPaddingSize.padding_12,
                                                top: 10),
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  S.of(context).Discover,
                                                  style: AppTextStyle
                                                      .getRegularStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize:
                                                              AppPaddingSize
                                                                  .padding_16),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom:
                                                    AppPaddingSize.padding_1),
                                            child: Column(
                                              children: categoriesWithChildren
                                                  .map((category) {
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                      color: AppColors.greyDD,
                                                      width: 0.8,
                                                    )),
                                                  ),
                                                  child: ExpansionTile(
                                                    key: ValueKey(category.id),
                                                    backgroundColor:
                                                        AppColors.white,
                                                    collapsedBackgroundColor:
                                                        AppColors.white,
                                                    title: Text(
                                                      category.categoryName ??
                                                          "",
                                                      style: AppTextStyle
                                                          .getBoldStyle(
                                                              color: AppColors
                                                                  .black),
                                                    ),
                                                    children: [
                                                      GridView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          crossAxisSpacing: 0.0,
                                                          mainAxisSpacing: 10.0,
                                                        ),
                                                        itemCount: category
                                                                .children
                                                                ?.length ??
                                                            0,
                                                        itemBuilder: (context,
                                                            subIndex) {
                                                          return Column(
                                                            children: [
                                                              Container(
                                                                height: 50.h,
                                                                width: 65.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColors
                                                                        .greyE5,
                                                                    width:
                                                                        0.8.w,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                ),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    int initialIndex = categoriesWithNoChildren.indexWhere((cat) =>
                                                                        cat.id ==
                                                                        category
                                                                            .children?[subIndex]
                                                                            .id);

                                                                    Navigation.push(ShoppingDetailsScreen(
                                                                        initialIndex: initialIndex >=
                                                                                0
                                                                            ? initialIndex
                                                                            : 0,
                                                                        categoryId: category
                                                                            .children?[subIndex]
                                                                            .id));
                                                                  },
                                                                  child: Center(
                                                                    child:
                                                                        CachedImage(
                                                                      height:
                                                                          40.h,
                                                                      imageUrl: (category.children?[subIndex].documents != null &&
                                                                              category.children![subIndex].documents!.isNotEmpty)
                                                                          ? "$baseUrl${category.children?[subIndex].documents!.first.filePath}/${category.children?[subIndex].documents!.first.fileName}"
                                                                          : logoPngImage,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                category
                                                                        .children?[
                                                                            subIndex]
                                                                        .categoryName ??
                                                                    "",
                                                                style: AppTextStyle
                                                                    .getRegularStyle(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          Card(
                            color: AppColors.white,
                            child: Column(
                              children: [
                                Align(
                                  alignment: prefs?.getString("lang") == "en"
                                      ? Alignment.topLeft
                                      : Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      S.of(context).Highend_Brand,
                                      style: AppTextStyle.getMediumStyle(
                                          color: AppColors.black,
                                          fontSize: AppPaddingSize.padding_20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: SizedBox(
                                    height: 180.h,
                                    child: PaginationList<BrandModel>(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      withRefresh: false,
                                      loadingHeight: 200.h,
                                      onCubitCreated: (cubit) {
                                        context.read<BrandCubit>().brandCubit =
                                            cubit;
                                      },
                                      repositoryCallBack: (data) {
                                        if (data.skip == 0) {
                                          data.take = 9;
                                        }
                                        if (data.skip >= 10) {
                                          data.skip += 10;
                                        }

                                        return context
                                            .read<BrandCubit>()
                                            .fetchMatrixByCategory(
                                                context
                                                    .read<BrandCubit>()
                                                    .selectedCategoryId,
                                                data);
                                      },
                                      listBuilder: (list) => AutoHeightGridView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            list.length > 6 ? 6 : list.length,
                                        padding: const EdgeInsets.all(
                                            AppPaddingSize.padding_8),
                                        crossAxisCount: 3,
                                        shrinkWrap: true,
                                        crossAxisSpacing:
                                            AppPaddingSize.padding_10,
                                        mainAxisSpacing:
                                            AppPaddingSize.padding_10,
                                        builder: (context, index) {
                                          final imageUrl = (list[index]
                                                          .document !=
                                                      null &&
                                                  list[index]
                                                      .document!
                                                      .isNotEmpty &&
                                                  list[index]
                                                          .document!
                                                          .first
                                                          .filePath !=
                                                      null &&
                                                  list[index]
                                                          .document!
                                                          .first
                                                          .fileName !=
                                                      null)
                                              ? "$baseUrl${list[index].document!.first.filePath}/${list[index].document!.first.fileName}"
                                              : logoPngImage;
                                          return GestureDetector(
                                            onTap: () {},
                                            child: BrandCard(
                                              onTap: () {
                                                Navigation.push(
                                                    MatrixByBrandScreen(
                                                  brandLogo: imageUrl,
                                                  brandName:
                                                      list[index].brandName,
                                                  color: list[index].colorCode,
                                                  brandId: list[index].id ?? "",
                                                ));
                                              },
                                              fit: BoxFit.contain,
                                              brandModel: list[index],
                                              color: Colors.transparent,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
