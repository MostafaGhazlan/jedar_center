import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/ui/widgets/back_widget.dart';
import 'package:flutter_application_1/features/notification/cubit/notification_cubit.dart';
import 'package:flutter_application_1/features/notification/data/model/notification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../widget/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.evenLighterBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: const BackWidget(
            title: "Notifications",
            existBack: false,
          ),
        ),
        body: PaginationList<NotificationModel>(
          loadingHeight: 200.h,
          withPagination: true,
          onCubitCreated: (cubit) {
            context.read<NotificationCubit>().notificationCubit = cubit;
          },
          repositoryCallBack: (data) {
            return context.read<NotificationCubit>().fetchAllNotification(data);
          },
          listBuilder: (list) => ListView.separated(
            itemBuilder: (context, index) {
              return NotificationCard(
                notificationModel: list[index],
              );
            },
            itemCount: list.length,
            padding: const EdgeInsets.only(
                bottom: AppPaddingSize.padding_100,
                top: AppPaddingSize.padding_16),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: AppPaddingSize.padding_16,
              );
            },
          ),
        ));
  }
}
