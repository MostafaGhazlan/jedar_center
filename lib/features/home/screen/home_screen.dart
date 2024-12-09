import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
import 'package:flutter_application_1/core/ui/widgets/search_delegate.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/auth/screen/login_screen.dart';
import 'package:flutter_application_1/features/auth/screen/signup_screen.dart';
import 'package:flutter_application_1/features/brand/cubit/brand_cubit.dart';
import 'package:flutter_application_1/features/brand/data/model/brand.dart';
import 'package:flutter_application_1/features/brand/screen/brand_screen.dart';
import 'package:flutter_application_1/features/matrix/cubit/matrix_cubit.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/matrix/screen/matrix_screen.dart';
import 'package:flutter_application_1/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_images/app_images.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/constant/text_styles/font_size.dart';
import '../../../core/ui/widgets/carousel_slider.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/double_back.dart';
import '../../brand/screen/matrix_by_brand_screen.dart';
import '../../matrix/screen/matrix_details_screen.dart';
import '../../matrix/widget/matrix_card2.dart';
import '../../search/cubit/search_cubit.dart';
import '../../sliderBanner/cubit/slider_banner_cubit.dart';
import '../../sliderBanner/data/model/slider_banner_model.dart';
import '../cubit/cubit/home_cubit.dart';
import '../../../core/ui/widgets/appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constant/app_padding/app_padding.dart';
import '../../brand/widget/brand_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();

  void _onRefresh(BuildContext context) {
    setState(() {
      context
          .read<SliderBannerCubit>()
          .fetchSlider(GetListRequest(skip: 0, take: 10));
      context
          .read<BrandCubit>()
          .fetchHomeBrand(GetListRequest(skip: 0, take: 10));
      context
          .read<MatrixCubit>()
          .fetchMostSoldMatrix(GetListRequest(skip: 0, take: 10));
      context
          .read<MatrixCubit>()
          .fetchHomeMatrix(GetListRequest(skip: 0, take: 10));
      context.read<SliderBannerCubit>().productCubit?.getList();
      context.read<BrandCubit>().brandCubit?.getList();
      context.read<MatrixCubit>().matrixCubit?.getList();
      context.read<MatrixCubit>().matrixCubit1?.getList();
    });

    _refreshController.refreshCompleted();
  }

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
        body: SmartRefresher(
          header: const MaterialClassicHeader(
            backgroundColor: AppColors.primary,
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CacheHelper.token == null
                    ? Padding(
                        padding: const EdgeInsets.all(AppPaddingSize.padding_5),
                        child: Text(
                          S.of(context).YOU_ARE_HERE,
                          style: AppTextStyle.getBoldStyle(
                            color: AppColors.primary,
                            fontSize: AppFontSize.size_20,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                CacheHelper.token == null
                    ? Padding(
                        padding: const EdgeInsets.all(AppPaddingSize.padding_5),
                        child: Text(
                          S.of(context).Hi,
                          style: AppTextStyle.getSemiBoldStyle(
                            color: AppColors.primary,
                            fontSize: AppFontSize.size_20,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                CacheHelper.token == null
                    ? Padding(
                        padding: const EdgeInsets.all(AppPaddingSize.padding_5),
                        child: Text(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          S.of(context).SignIn_title,
                          style: AppTextStyle.getSemiBoldStyle(
                            color: AppColors.black,
                            fontSize: AppFontSize.size_18,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                CacheHelper.token == null
                    ? Padding(
                        padding:
                            const EdgeInsets.all(AppPaddingSize.padding_10),
                        child: CustomButton(
                          onPressed: () {
                            Navigation.push(const LoginScreen());
                          },
                          text: S.of(context).SignIn,
                          w: 200.h,
                        ),
                      )
                    : const SizedBox.shrink(),
                CacheHelper.token == null
                    ? Padding(
                        padding: const EdgeInsets.all(AppPaddingSize.padding_5),
                        child: TextButton(
                          onPressed: () {
                            Navigation.push(SignUpScreen());
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            S.of(context).Create_Account,
                            style: AppTextStyle.getSemiBoldStyle(
                              color: AppColors.blueFace,
                              fontSize: AppFontSize.size_16,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                BlocBuilder<SliderBannerCubit, SliderBannerState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: context
                              .read<SliderBannerCubit>()
                              .totalResultCountSlider *
                          135,
                      child: PaginationList<SliderBannerModel>(
                        withPagination: false,
                        onCubitCreated: (cubit) {
                          context.read<SliderBannerCubit>().productCubit =
                              cubit;
                        },
                        repositoryCallBack: (data) {
                          return context
                              .read<SliderBannerCubit>()
                              .fetchSlider(data);
                        },
                        listBuilder: (list) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              List<String> images = [];
                              for (var detailsElement in item.details!) {
                                images.add(
                                    "$baseUrl${detailsElement.document?.filePath}/${detailsElement.document?.fileName}");
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8),
                                child: CarouselWidget(
                                  onTap: (subindex) async {
                                    if (list[index].details!.isEmpty) {
                                      return;
                                    }

                                    final detail =
                                        list[index].details![subindex];

                                    if (detail.sliderType == 1 ||
                                        detail.sliderType == 0) {
                                      return;
                                    }
                                    if (detail.sliderType == 2) {
                                      if (detail.discountFrom != null &&
                                          detail.discountFrom != 0) {
                                        context
                                                .read<SearchCubit>()
                                                .searchParams
                                                .discountFrom =
                                            detail.discountFrom!;
                                      } else {
                                        return;
                                      }
                                      if (detail.discountTo != null &&
                                          detail.discountTo != 0) {
                                        context
                                            .read<SearchCubit>()
                                            .searchParams
                                            .discountTo = detail.discountTo!;
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 3) {
                                      if (detail.categoryId != null &&
                                          detail.categoryId != 0) {
                                        context
                                            .read<SearchCubit>()
                                            .searchParams
                                            .categoryIntIds = [
                                          detail.categoryId!
                                        ];
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 4) {
                                      if (detail.url != null) {
                                        if (!await launchUrl(
                                            Uri.parse(detail.url!))) {
                                          throw Exception(
                                              'Could not launch ${detail.url}');
                                        }
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 5) {
                                      if (detail.matrixId != null &&
                                          detail.matrixId != 0) {
                                        GetModel<MatrixModel>(
                                          withoutCenterLoading: true,
                                          withAnimation: false,
                                          useCaseCallBack: () {
                                            return context
                                                .read<MatrixCubit>()
                                                .fetchOneMatrix(
                                                    detail.matrixId!);
                                          },
                                        );
                                        if (context.mounted) {
                                          Navigation.push(ProductDetailsScreen(
                                              model: context
                                                  .read<MatrixCubit>()
                                                  .matrix!));
                                        }
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 6) {
                                      if (detail.brandId != null) {
                                        if (context.mounted) {
                                          context
                                              .read<SearchCubit>()
                                              .selectedBrandIds
                                              .clear();
                                          context
                                              .read<SearchCubit>()
                                              .selectedBrandIds
                                              .add(detail.brandId!);
                                          context
                                                  .read<SearchCubit>()
                                                  .searchParams
                                                  .brandIds =
                                              context
                                                  .read<SearchCubit>()
                                                  .selectedBrandIds;
                                        }
                                      } else {
                                        return;
                                      }
                                    }

                                    final searchDelegate = DataSearch();
                                    if (context.mounted) {
                                      showSearch(
                                        context: context,
                                        delegate: searchDelegate,
                                      );

                                      searchDelegate.showResults(context);
                                    }
                                  },
                                  autoPlay: true,
                                  photoFit: BoxFit.fill,
                                  images: images,
                                  controller: CarouselSliderController(),
                                  onPageChanged: (index) => context
                                      .read<HomeCubit>()
                                      .changeCarouselIndex(index),
                                  currentIndexIndicator:
                                      context.read<HomeCubit>().carouselIndex,
                                  viewportFraction: 1,
                                  padding: 2,
                                  height: 120,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppPaddingSize.padding_20,
                          left: AppPaddingSize.padding_20,
                          right: AppPaddingSize.padding_20),
                      child: Text(
                        S.of(context).Brands,
                        style: AppTextStyle.getBoldStyle(
                          color: AppColors.black28,
                          fontSize: AppFontSize.size_20,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: AppPaddingSize.padding_20,
                            right: AppPaddingSize.padding_20),
                        child: TextButton(
                          onPressed: () {
                            Navigation.push(const BrandScreen());
                          },
                          child: Text(
                            S.of(context).See_more,
                            style: AppTextStyle.getMediumStyle(
                              color: AppColors.grey72,
                              fontSize: AppFontSize.size_15,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )),
                  ],
                ),
                BlocBuilder<BrandCubit, BrandState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 150.h,
                      child: PaginationList<BrandModel>(
                          scrollDirection: Axis.horizontal,
                          withPagination: false,
                          onCubitCreated: (cubit) {
                            context.read<BrandCubit>().brandCubit = cubit;
                          },
                          repositoryCallBack: (data) {
                            return context
                                .read<BrandCubit>()
                                .fetchHomeBrand(data);
                          },
                          listBuilder: (list) => ListView.separated(
                                itemBuilder: (context, index) {
                                  final imageUrl = (list[index].document !=
                                              null &&
                                          list[index].document!.isNotEmpty &&
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
                                itemCount: list.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: AppPaddingSize.padding_16,
                                  );
                                },
                              )),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppPaddingSize.padding_20,
                          left: AppPaddingSize.padding_20,
                          right: AppPaddingSize.padding_20),
                      child: Text(
                        S.of(context).Most_Sold,
                        style: AppTextStyle.getBoldStyle(
                          color: AppColors.black28,
                          fontSize: AppFontSize.size_20,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: AppPaddingSize.padding_20,
                            right: AppPaddingSize.padding_20),
                        child: TextButton(
                          onPressed: () {
                            Navigation.push(const MatrixScreen());
                          },
                          child: Text(
                            S.of(context).See_more,
                            style: AppTextStyle.getMediumStyle(
                              color: AppColors.grey72,
                              fontSize: AppFontSize.size_15,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )),
                  ],
                ),
                BlocBuilder<MatrixCubit, MatrixState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppPaddingSize.padding_10),
                      child: SizedBox(
                        height: 346,
                        child: PaginationList<MatrixModel>(
                          scrollDirection: Axis.horizontal,
                          withPagination: false,
                          onCubitCreated: (cubit) {
                            context.read<MatrixCubit>().matrixCubit = cubit;
                          },
                          repositoryCallBack: (data) {
                            return context
                                .read<MatrixCubit>()
                                .fetchMostSoldMatrix(data);
                          },
                          listBuilder: (list) => ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return MatrixCard2(
                                height: 310,
                                matrixModel: list[index],
                              );
                            },
                            itemCount: list.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: AppPaddingSize.padding_16,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppPaddingSize.padding_20,
                          left: AppPaddingSize.padding_20,
                          right: AppPaddingSize.padding_20),
                      child: Text(
                        S.of(context).Highend_Brand,
                        style: AppTextStyle.getBoldStyle(
                          color: AppColors.black28,
                          fontSize: AppFontSize.size_20,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<SliderBannerCubit, SliderBannerState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: context
                              .read<SliderBannerCubit>()
                              .totalResultCountSlider *
                          135,
                      child: PaginationList<SliderBannerModel>(
                        withPagination: false,
                        onCubitCreated: (cubit) {
                          context.read<SliderBannerCubit>().productCubit =
                              cubit;
                        },
                        repositoryCallBack: (data) {
                          // if (data.skip == 0) {
                          //   data.take = 1;
                          // }

                          return context
                              .read<SliderBannerCubit>()
                              .fetchSlider(data);
                        },
                        listBuilder: (list) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              List<String> images = [];
                              for (var detailsElement in item.details!) {
                                images.add(
                                    "$baseUrl${detailsElement.document?.filePath}/${detailsElement.document?.fileName}");
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8),
                                child: CarouselWidget(
                                  onTap: (subindex) async {
                                    if (list[index].details!.isEmpty) {
                                      return;
                                    }

                                    final detail =
                                        list[index].details![subindex];

                                    if (detail.sliderType == 1 ||
                                        detail.sliderType == 0) {
                                      return;
                                    }
                                    if (detail.sliderType == 2) {
                                      if (detail.discountFrom != null &&
                                          detail.discountFrom != 0) {
                                        context
                                                .read<SearchCubit>()
                                                .searchParams
                                                .discountFrom =
                                            detail.discountFrom!;
                                      } else {
                                        return;
                                      }
                                      if (detail.discountTo != null &&
                                          detail.discountTo != 0) {
                                        context
                                            .read<SearchCubit>()
                                            .searchParams
                                            .discountTo = detail.discountTo!;
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 3) {
                                      if (detail.categoryId != null &&
                                          detail.categoryId != 0) {
                                        context
                                            .read<SearchCubit>()
                                            .searchParams
                                            .categoryIntIds = [
                                          detail.categoryId!
                                        ];
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 4) {
                                      if (detail.url != null) {
                                        if (!await launchUrl(
                                            Uri.parse(detail.url!))) {
                                          throw Exception(
                                              'Could not launch ${detail.url}');
                                        }
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 5) {
                                      if (detail.matrixId != null &&
                                          detail.matrixId != 0) {
                                        GetModel<MatrixModel>(
                                          withoutCenterLoading: true,
                                          withAnimation: false,
                                          useCaseCallBack: () {
                                            return context
                                                .read<MatrixCubit>()
                                                .fetchOneMatrix(
                                                    detail.matrixId!);
                                          },
                                        );
                                        if (context.mounted) {
                                          Navigation.push(ProductDetailsScreen(
                                              model: context
                                                  .read<MatrixCubit>()
                                                  .matrix!));
                                        }
                                      } else {
                                        return;
                                      }
                                    }
                                    if (detail.sliderType == 6) {
                                      if (detail.brandId != null) {
                                        if (context.mounted) {
                                          context
                                              .read<SearchCubit>()
                                              .selectedBrandIds
                                              .clear();
                                          context
                                              .read<SearchCubit>()
                                              .selectedBrandIds
                                              .add(detail.brandId!);
                                          context
                                                  .read<SearchCubit>()
                                                  .searchParams
                                                  .brandIds =
                                              context
                                                  .read<SearchCubit>()
                                                  .selectedBrandIds;
                                        }
                                      } else {
                                        return;
                                      }
                                    }

                                    final searchDelegate = DataSearch();
                                    if (context.mounted) {
                                      showSearch(
                                        context: context,
                                        delegate: searchDelegate,
                                      );

                                      searchDelegate.showResults(context);
                                    }
                                  },
                                  autoPlay: true,
                                  photoFit: BoxFit.fill,
                                  images: images,
                                  controller: CarouselSliderController(),
                                  onPageChanged: (index) => context
                                      .read<HomeCubit>()
                                      .changeCarouselIndex(index),
                                  currentIndexIndicator:
                                      context.read<HomeCubit>().carouselIndex,
                                  viewportFraction: 1,
                                  padding: 2,
                                  height: 120,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
