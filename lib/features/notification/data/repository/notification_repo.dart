import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/core/variables/variables.dart';
import 'package:flutter_application_1/features/notification/data/usecase/notification_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../model/notification_model.dart';

class NotificationRepository extends CoreRepository {
  Future<Result<List<NotificationModel>>> notificationRequest(
      {required NotificationParams params}) async {
    final result = await RemoteDataSource.request<List<NotificationModel>>(
        withAuthentication: false,
        url: notificationUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'NotificationResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<NotificationModel>.from(
                  json["items"]!.map((x) => NotificationModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }


}
