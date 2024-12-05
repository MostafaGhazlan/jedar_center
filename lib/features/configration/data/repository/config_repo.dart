import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/features/configration/data/usecase/config_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../model/config_model.dart';
import '../usecase/set_decive_id_usecase.dart';

class ConfigRepository extends CoreRepository {
  Future<Result<CurrentUserModel>> currentUserRequest(
      {required ConfigParams params}) async {
    final result = await RemoteDataSource.request<CurrentUserModel>(
      withAuthentication: true,
      url: configUrl,
      method: HttpMethod.GET,
      responseStr: 'CurrentUserResponse',
      converter: (json) {
        return json["currentUser"] == null
            ? null
            : CurrentUserModel.fromJson(json["currentUser"]);
      },
    );

    return call(result: result);
  }

  Future<Result<CurrentUserModel>> setDeviceIdParamsRequest(
      {required SetDeviceIdParams params}) async {
    final result = await RemoteDataSource.request<CurrentUserModel>(
        withAuthentication: true,
        data: params.toJson(),
        url: setDeviceIdUrl,
        method: HttpMethod.POST,
        responseStr: 'CreateOrderResponse',
        converter: (json) {
          return CurrentUserModel.fromJson(json);
        });

    return call(result: result);
  }
}
