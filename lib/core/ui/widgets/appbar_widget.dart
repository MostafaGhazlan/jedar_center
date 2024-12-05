import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_icons/app_icons.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/search/cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/notification/screen/notification_screen.dart';
import '../../../features/root/cubit/root_cubit.dart';
import '../../../generated/l10n.dart';
import '../../constant/app_colors/app_colors.dart';
import 'custom_text_form_field.dart';
import 'search_delegate.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    context.read<SearchCubit>().autoCompleteSearch("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.read<RootCubit>().changePageIndex(4);
            },
            icon: SvgPicture.asset(
              categoriesImage,
              height: AppPaddingSize.padding_35,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: DataSearch());
              },
              child: AbsorbPointer(
                child: CustomTextFormField(
                  hintText: S.of(context).Search,
                  fillColor: AppColors.greyE5,
                  height: 30.h,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppPaddingSize.padding_10),
          IconButton(
            onPressed: () {
              Navigation.push(const NotificationScreen());
            },
            icon: const Icon(
              Icons.notifications_none,
              size: AppPaddingSize.padding_35,
            ),
          ),
        ],
      ),
    );
  }
}
