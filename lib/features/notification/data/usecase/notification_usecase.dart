import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/notification/data/repository/notification_repo.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';
import '../model/notification_model.dart';

class NotificationParams extends BaseParams {
  final GetListRequest? request;

  NotificationParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class NotificationUsecase extends UseCase<List<NotificationModel>, NotificationParams> {
  late final NotificationRepository repository;
  NotificationUsecase(this.repository);

  @override
  Future<Result<List<NotificationModel>>> call({required NotificationParams params}) {
    return repository.notificationRequest(params: params);
  }
}
