import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:flutter_application_1/features/notification/data/repository/notification_repo.dart';
import 'package:flutter_application_1/features/notification/data/usecase/notification_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/results/result.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  PaginationCubit? notificationCubit;
  NotificationCubit() : super(NotificationInitial());

  Future<Result> fetchAllNotification(data) async {
    return await NotificationUsecase(NotificationRepository())
        .call(params: NotificationParams(request: data));
  }

}
