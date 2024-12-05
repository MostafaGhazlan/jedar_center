// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/classes/cashe_helper.dart';
// import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
// import 'package:flutter_application_1/core/ui/extination/app_extension.dart';
// import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
// import 'package:flutter_application_1/features/matrix/cubit/matrix_cubit.dart';
// import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../core/constant/app_colors/app_colors.dart';
// import '../../../core/constant/app_icons/app_icons.dart';
// import '../../../core/constant/app_padding/app_padding.dart';
// import '../../../core/constant/text_styles/app_text_style.dart';
// import '../../../core/constant/text_styles/font_size.dart';
// import '../../../core/ui/dialogs/dialogs.dart';
// import '../../../core/ui/widgets/carousel_slider.dart';
// import '../../../generated/l10n.dart';
// import '../../home/cubit/cubit/home_cubit.dart';
// import '../screen/matrix_details_screen.dart';

// class MatrixCard extends StatelessWidget {
//   final Function()? whenSuccess;
//   final Function()? whenError;
//   final bool isDisscount;
//   final MatrixModel matrixModel;

//   const MatrixCard(
//       {super.key,
//       this.whenSuccess,
//       this.whenError,
//       required this.matrixModel,
//       required this.isDisscount});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigation.push(ProductDetailsScreen(
//           matrixId: matrixModel.id ?? 1,
//           matrixModel: matrixModel,
//         ));
//       },
//       child: Container(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         width: 200.w,
//         decoration: BoxDecoration(
//             border: Border.all(
//               color: AppColors.greyDD,
//             ),
//             borderRadius: const BorderRadius.all(Radius.circular(14)),
//             color: AppColors.evenLighterBackground),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.topEnd,
//               children: [
//                 CarouselWidget(
//                   autoPlay: false,
//                   photoFit: BoxFit.fill,
//                   images: ["$baseUrl${matrixModel.imageName}"],
//                   controller: CarouselSliderController(),
//                   onPageChanged: (index) =>
//                       context.read<HomeCubit>().changeCarouselIndex(index),
//                   currentIndexIndicator:
//                       context.read<HomeCubit>().carouselIndex,
//                   viewportFraction: 1,
//                   padding: 2,
//                   height: 240.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(AppPaddingSize.padding_10),
//                       child: BlocBuilder<MatrixCubit, MatrixState>(
//                         builder: (context, state) {
//                           bool isFavorite = CacheHelper.wishlist
//                                   ?.any((item) => item.id == matrixModel.id) ??
//                               false;

//                           if (state is FavoritLoading) {
//                             return const CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation(AppColors.red),
//                               strokeWidth: 3.0,
//                             );
//                           }

//                           return IconButton(
//                             onPressed: () async {
//                               matrixModel.isFavorite = !matrixModel.isFavorite;
//                               await context
//                                   .read<MatrixCubit>()
//                                   .changeFavorite(matrixModel);
//                             },
//                             icon: isFavorite
//                                 ? Icon(
//                                     Icons.favorite,
//                                     size: 30.h,
//                                     color: AppColors.red,
//                                   )
//                                 : Icon(
//                                     Icons.favorite_outline,
//                                     size: 30.h,
//                                     color: AppColors.black,
//                                   ),
//                           );
//                         },
//                       ),
//                     ),
//                     isDisscount
//                         ? Padding(
//                             padding:
//                                 const EdgeInsets.all(AppPaddingSize.padding_10),
//                             child: BlocBuilder<MatrixCubit, MatrixState>(
//                               builder: (context, state) {
//                                 return IconButton(
//                                   onPressed: () {},
//                                   icon: SvgPicture.asset(
//                                     color: AppColors.pink,
//                                     discountImage,
//                                     height: 40.h,
//                                   ),
//                                 );
//                               },
//                             ),
//                           )
//                         : const SizedBox.shrink(),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: AppPaddingSize.padding_8,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: AppFontSize.size_4, right: AppFontSize.size_4),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     matrixModel.matrixName ?? "Product Name",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: AppTextStyle.getBoldStyle(
//                       color: AppColors.black,
//                       fontSize: AppFontSize.size_14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   matrixModel.notes ?? "product Description",
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                   style: AppTextStyle.getBoldStyle(
//                     color: AppColors.black,
//                     fontSize: AppFontSize.size_12,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: AppPaddingSize.padding_8,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(AppPaddingSize.padding_8),
//                   child: Text(
//                     "${matrixModel.product?.price1 ?? "25,000 ${S.of(context).IQD}"} ${S.of(context).IQD}",
//                     maxLines: 2,
//                     textAlign: TextAlign.center,
//                     overflow: TextOverflow.ellipsis,
//                     style: AppTextStyle.getMediumStyle(
//                       color: AppColors.red,
//                       fontSize: AppFontSize.size_16,
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.all(AppPaddingSize.padding_8),
//                   child: IconButton(
//                       onPressed: () async {
//                         try {
//                           await CacheHelper.addToCart(matrixModel, true);
//                           Dialogs.showSnackBar(
//                               message: S.of(context).Product_added);
//                         } catch (e) {
//                           if (kDebugMode) {
//                             print(e.toString());
//                           }
//                         }
//                       },
//                       icon: const Icon(Icons.add_box_rounded)),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ).fadeAnimation(0.5),
//     );
//   }
// }
