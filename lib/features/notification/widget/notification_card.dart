import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/features/notification/data/model/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPaddingSize.padding_8),
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.notifications,
                color: AppColors.white,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                child: Text(
                  notificationModel.title ?? "Title",
                  style: AppTextStyle.getRegularStyle(
                      color: AppColors.black,
                      fontSize: AppPaddingSize.padding_10),
                ),
              ),
              const SizedBox(
                height: AppPaddingSize.padding_5,
              ),
              Padding(
                padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                child: Text(
                  notificationModel.body ?? "Body",
                  style: AppTextStyle.getRegularStyle(
                      color: AppColors.black,
                      fontSize: AppPaddingSize.padding_10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
