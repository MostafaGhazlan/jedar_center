import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/app_responsive/responsive.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/utils/Navigation/navigation.dart';
import '../../../generated/l10n.dart';
import '../../brand/cubit/brand_cubit.dart';
import '../../brand/data/model/brand.dart';
import '../../matrix/data/model/matrix.dart';
import '../../matrix/widget/matrix_card2.dart';
import '../../shopping/cubit/shopping_cubit.dart';
import '../../shopping/data/model/category.dart';
import '../cubit/search_cubit.dart';

class BuildResultSearch {
  final Function(BuildContext) onFilter;

  BuildResultSearch({required this.onFilter});

  Widget buildResult(BuildContext context, Function(String) closeSearch) {
    return Container(
      color: AppColors.evenLighterBackground,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          clipBehavior: Clip.antiAlias,
                          builder: (context) {
                            return SizedBox(
                              height: 350.h,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          S.of(context).Reset,
                                          style: AppTextStyle.getMediumStyle(
                                              color: AppColors.greyAD,
                                              fontSize:
                                                  AppPaddingSize.padding_12),
                                        ),
                                      ),
                                      Text(
                                        S.of(context).Brands,
                                        style: AppTextStyle.getSemiBoldStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_14),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigation.pop();
                                          },
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ))
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 300.h,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 80),
                                          child: PaginationList<BrandModel>(
                                            loadingHeight: 200.h,
                                            withPagination: true,
                                            onCubitCreated: (cubit) {
                                              context
                                                  .read<BrandCubit>()
                                                  .brandCubit = cubit;
                                            },
                                            repositoryCallBack: (data) {
                                              return context
                                                  .read<BrandCubit>()
                                                  .fetchAllBrand(data);
                                            },
                                            listBuilder: (list) =>
                                                ListView.builder(
                                              itemCount: list.length,
                                              padding: const EdgeInsets.all(
                                                  AppPaddingSize.padding_8),
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                var isChecked = context
                                                    .read<SearchCubit>()
                                                    .selectedBrandIds
                                                    .contains(list[index].id);

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<SearchCubit>()
                                                          .toggleBrandSelection(
                                                            list[index].id ??
                                                                "",
                                                            !isChecked,
                                                          );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    SearchCubit>()
                                                                .toggleBrandSelection(
                                                                  list[index]
                                                                          .id ??
                                                                      "",
                                                                  !isChecked,
                                                                );
                                                          },
                                                          child: BlocBuilder<
                                                              SearchCubit,
                                                              SearchState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is UpdateCheckState) {
                                                                isChecked = state
                                                                    .selectedIds
                                                                    .contains(
                                                                        list[index]
                                                                            .id);
                                                              }
                                                              return Container(
                                                                width: 24,
                                                                height: 24,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color:
                                                                        AppColors
                                                                            .primary,
                                                                    width: 2,
                                                                  ),
                                                                  color: isChecked
                                                                      ? AppColors
                                                                          .primary
                                                                      : Colors
                                                                          .transparent,
                                                                ),
                                                                child: isChecked
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            16,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width:
                                                                AppPaddingSize
                                                                    .padding_8),
                                                        Text(
                                                          list[index]
                                                                  .brandName ??
                                                              S
                                                                  .of(context)
                                                                  .Brands,
                                                          style: AppTextStyle
                                                              .getMediumStyle(
                                                                  color: AppColors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                        child: CustomButton(
                                          text: S.of(context).Apply,
                                          textStyle:
                                              AppTextStyle.getMediumStyle(
                                                  color: AppColors.white),
                                          onPressed: () {
                                            context
                                                    .read<SearchCubit>()
                                                    .searchParams
                                                    .brandIds =
                                                context
                                                    .read<SearchCubit>()
                                                    .selectedBrandIds;

                                            Navigation.pop();
                                            onFilter(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: BlocBuilder<SearchCubit, SearchState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).Brands,
                                        style: AppTextStyle.getMediumStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_15)),
                                    const Icon(Icons.arrow_drop_down_rounded),
                                    context
                                            .read<SearchCubit>()
                                            .selectedBrandIds
                                            .isEmpty
                                        ? const SizedBox.shrink()
                                        : const Icon(
                                            Icons.circle,
                                            color: AppColors.red,
                                            size: AppPaddingSize.padding_10,
                                          )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          clipBehavior: Clip.antiAlias,
                          builder: (context) {
                            return SizedBox(
                              height: 350.h,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          S.of(context).Reset,
                                          style: AppTextStyle.getMediumStyle(
                                              color: AppColors.greyAD,
                                              fontSize:
                                                  AppPaddingSize.padding_12),
                                        ),
                                      ),
                                      Text(
                                        S.of(context).Shopping,
                                        style: AppTextStyle.getSemiBoldStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_14),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigation.pop();
                                          },
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ))
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 300.h,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 80),
                                          child: PaginationList<CategoryModel>(
                                            loadingHeight: 200.h,
                                            withPagination: true,
                                            onCubitCreated: (cubit) {
                                              context
                                                  .read<ShoppingCubit>()
                                                  .categoryCubit = cubit;
                                            },
                                            repositoryCallBack: (data) {
                                              return context
                                                  .read<ShoppingCubit>()
                                                  .fetchAllCategoryForSearch(
                                                      data);
                                            },
                                            listBuilder: (list) =>
                                                ListView.builder(
                                              itemCount: list.length,
                                              padding: const EdgeInsets.all(
                                                  AppPaddingSize.padding_8),
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                var isChecked = context
                                                    .read<SearchCubit>()
                                                    .selectedCategoriesIds
                                                    .contains(list[index].id);

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<SearchCubit>()
                                                          .toggleCategorySelection(
                                                            list[index].id ??
                                                                "",
                                                            !isChecked,
                                                          );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    SearchCubit>()
                                                                .toggleCategorySelection(
                                                                  list[index]
                                                                          .id ??
                                                                      "",
                                                                  !isChecked,
                                                                );
                                                          },
                                                          child: BlocBuilder<
                                                              SearchCubit,
                                                              SearchState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is UpdateCheckState) {
                                                                isChecked = state
                                                                    .selectedIds
                                                                    .contains(
                                                                        list[index]
                                                                            .id);
                                                              }
                                                              return Container(
                                                                width: 24,
                                                                height: 24,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color:
                                                                        AppColors
                                                                            .primary,
                                                                    width: 2,
                                                                  ),
                                                                  color: isChecked
                                                                      ? AppColors
                                                                          .primary
                                                                      : Colors
                                                                          .transparent,
                                                                ),
                                                                child: isChecked
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            16,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width:
                                                                AppPaddingSize
                                                                    .padding_8),
                                                        Text(
                                                          list[index]
                                                                  .categoryName ??
                                                              S
                                                                  .of(context)
                                                                  .Shopping,
                                                          style: AppTextStyle
                                                              .getMediumStyle(
                                                                  color: AppColors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                        child: CustomButton(
                                          text: S.of(context).Apply,
                                          textStyle:
                                              AppTextStyle.getMediumStyle(
                                                  color: AppColors.white),
                                          onPressed: () {
                                            context
                                                    .read<SearchCubit>()
                                                    .searchParams
                                                    .categoryIds =
                                                context
                                                    .read<SearchCubit>()
                                                    .selectedCategoriesIds;

                                            Navigation.pop();
                                            onFilter(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: BlocBuilder<SearchCubit, SearchState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).Shopping,
                                        style: AppTextStyle.getMediumStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_15)),
                                    const Icon(Icons.arrow_drop_down_rounded),
                                    context
                                            .read<SearchCubit>()
                                            .selectedCategoriesIds
                                            .isEmpty
                                        ? const SizedBox.shrink()
                                        : const Icon(
                                            Icons.circle,
                                            color: AppColors.red,
                                            size: AppPaddingSize.padding_10,
                                          )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          clipBehavior: Clip.antiAlias,
                          builder: (context) {
                            final items = [
                              S.of(context).Sort_by_discount,
                              S.of(context).Sort_Price_Desc,
                              S.of(context).Sort_Price_Ask
                            ];
                            context
                                .read<SearchCubit>()
                                .initializeList(items.length);

                            return SizedBox(
                              height: 350.h,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          S.of(context).Reset,
                                          style: AppTextStyle.getMediumStyle(
                                            color: AppColors.greyAD,
                                            fontSize: AppPaddingSize.padding_12,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        S.of(context).Sort,
                                        style: AppTextStyle.getSemiBoldStyle(
                                          color: AppColors.black,
                                          fontSize: AppPaddingSize.padding_14,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigation.pop();
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 300.h,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 80),
                                          child: Column(
                                            children: List.generate(
                                                items.length, (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<SearchCubit>()
                                                        .switchFilter(index);
                                                  },
                                                  child: BlocBuilder<
                                                      SearchCubit, SearchState>(
                                                    builder: (context, state) {
                                                      final isChecked = context
                                                          .read<SearchCubit>()
                                                          .isCheckedList[index];

                                                      return Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Container(
                                                              width: 24,
                                                              height: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .primary,
                                                                  width: 2,
                                                                ),
                                                                color: isChecked
                                                                    ? AppColors
                                                                        .primary
                                                                    : Colors
                                                                        .transparent,
                                                              ),
                                                              child: isChecked
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check,
                                                                      size: 16,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : const SizedBox
                                                                      .shrink(),
                                                            ),
                                                          ),
                                                          Text(
                                                            items[index],
                                                            style: AppTextStyle
                                                                .getMediumStyle(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                        child: CustomButton(
                                          text: S.of(context).Apply,
                                          textStyle:
                                              AppTextStyle.getMediumStyle(
                                            color: AppColors.white,
                                          ),
                                          onPressed: () {
                                            final selectedItem = context
                                                .read<SearchCubit>()
                                                .getSelectedItem(items);

                                            context
                                                .read<SearchCubit>()
                                                .searchParams
                                              ..sortByDiscount = false
                                              ..sortByPriceDesc = false
                                              ..sortByPriceAsc = false;

                                            if (selectedItem ==
                                                S
                                                    .of(context)
                                                    .Sort_by_discount) {
                                              context
                                                  .read<SearchCubit>()
                                                  .searchParams
                                                  .sortByDiscount = true;
                                            }
                                            if (selectedItem ==
                                                S.of(context).Sort_Price_Desc) {
                                              context
                                                  .read<SearchCubit>()
                                                  .searchParams
                                                  .sortByPriceDesc = true;
                                            }
                                            if (selectedItem ==
                                                S.of(context).Sort_Price_Ask) {
                                              context
                                                  .read<SearchCubit>()
                                                  .searchParams
                                                  .sortByPriceAsc = true;
                                            }

                                            Navigation.pop();
                                            onFilter(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          color: AppColors.background,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).Sort,
                                    style: AppTextStyle.getMediumStyle(
                                      color: AppColors.black,
                                      fontSize: AppPaddingSize.padding_15,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down_rounded),
                                  BlocBuilder<SearchCubit, SearchState>(
                                    builder: (context, state) {
                                      final isAnySelected = context
                                          .read<SearchCubit>()
                                          .isCheckedList
                                          .any((isChecked) => isChecked);

                                      return isAnySelected
                                          ? const Icon(
                                              Icons.circle,
                                              color: AppColors.red,
                                              size: AppPaddingSize.padding_10,
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          clipBehavior: Clip.antiAlias,
                          builder: (context) {
                            return SizedBox(
                              height: 350.h,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          S.of(context).Reset,
                                          style: AppTextStyle.getMediumStyle(
                                              color: AppColors.greyAD,
                                              fontSize:
                                                  AppPaddingSize.padding_12),
                                        ),
                                      ),
                                      Text(
                                        S.of(context).Price_Range,
                                        style: AppTextStyle.getSemiBoldStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_14),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigation.pop();
                                          },
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ))
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 300.h,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 80, left: 20, right: 20),
                                          child: BlocBuilder<SearchCubit,
                                              SearchState>(
                                            builder: (context, state) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                              S
                                                                  .of(
                                                                      context)
                                                                  .Min,
                                                              style: AppTextStyle.getMediumStyle(
                                                                  color: AppColors
                                                                      .black,
                                                                  fontSize:
                                                                      AppPaddingSize
                                                                          .padding_12)),
                                                          const SizedBox(
                                                            height:
                                                                AppPaddingSize
                                                                    .padding_10,
                                                          ),
                                                          Text(context
                                                              .read<
                                                                  SearchCubit>()
                                                              .rangeLabels
                                                              .start),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .Max,
                                                            style: AppTextStyle.getMediumStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    AppPaddingSize
                                                                        .padding_12),
                                                          ),
                                                          const SizedBox(
                                                            height:
                                                                AppPaddingSize
                                                                    .padding_10,
                                                          ),
                                                          Text(context
                                                              .read<
                                                                  SearchCubit>()
                                                              .rangeLabels
                                                              .end),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: AppPaddingSize
                                                        .padding_100,
                                                  ),
                                                  RangeSlider(
                                                    onChangeStart: (value) {
                                                      context
                                                              .read<SearchCubit>()
                                                              .searchParams
                                                              .priceFrom =
                                                          value.start.toInt();
                                                    },
                                                    onChangeEnd: (value) {
                                                      context
                                                              .read<SearchCubit>()
                                                              .searchParams
                                                              .priceTo =
                                                          value.end.toInt();
                                                    },
                                                    activeColor: AppColors.primary,
                                                    min: 1000,
                                                    max: 300000,
                                                    divisions: 100,
                                                    labels: context
                                                        .read<SearchCubit>()
                                                        .rangeLabels,
                                                    values: context
                                                        .read<SearchCubit>()
                                                        .rangeValues,
                                                    onChanged: (value) {
                                                      double adjustedStart =
                                                          (value.start / 1000)
                                                                  .round() *
                                                              1000;
                                                      double adjustedEnd =
                                                          (value.end / 300000)
                                                                  .round() *
                                                              300000;

                                                      context
                                                          .read<SearchCubit>()
                                                          .range(
                                                            RangeValues(
                                                                adjustedStart,
                                                                adjustedEnd),
                                                          );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                        child: CustomButton(
                                          text: S.of(context).Apply,
                                          textStyle:
                                              AppTextStyle.getMediumStyle(
                                                  color: AppColors.white),
                                          onPressed: () {
                                            Navigation.pop();
                                            onFilter(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: BlocBuilder<SearchCubit, SearchState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).Price,
                                        style: AppTextStyle.getMediumStyle(
                                            color: AppColors.black,
                                            fontSize:
                                                AppPaddingSize.padding_15)),
                                    const Icon(Icons.arrow_drop_down_rounded),
                                    context
                                                    .read<SearchCubit>()
                                                    .rangeValues
                                                    .start ==
                                                1000 &&
                                            context
                                                    .read<SearchCubit>()
                                                    .rangeValues
                                                    .end ==
                                                300000
                                        ? const SizedBox.shrink()
                                        : const Icon(
                                            Icons.circle,
                                            color: AppColors.red,
                                            size: AppPaddingSize.padding_10,
                                          )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Text(S.of(context).Discount,
                                style: AppTextStyle.getMediumStyle(
                                    color: AppColors.black,
                                    fontSize: AppPaddingSize.padding_15)),
                            Switch(
                              activeColor: AppColors.primary,
                              value: context.read<SearchCubit>().isSwitched,
                              onChanged: (value) {
                                context.read<SearchCubit>().switched(value);
                                context
                                        .read<SearchCubit>()
                                        .searchParams
                                        .isDiscount =
                                    context.read<SearchCubit>().isSwitched;
                                onFilter(context);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PaginationList<MatrixModel>(
              loadingHeight: 200.h,
              withPagination: true,
              onCubitCreated: (cubit) {
                context.read<SearchCubit>().searchCubit = cubit;
              },
              repositoryCallBack: (data) {
                return context.read<SearchCubit>().search(data);
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
