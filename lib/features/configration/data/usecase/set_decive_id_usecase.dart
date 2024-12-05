import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/configration/data/repository/config_repo.dart';

import '../../../../core/results/result.dart';
import '../model/config_model.dart';

class SetDeviceIdParams extends BaseParams {
  String userId;
  String concurrencyStamp;
  String deviceId;
  SetDeviceIdParams({
    required this.userId,
    required this.concurrencyStamp,
    required this.deviceId,
  });
  toJson() {
    return {
      "id": userId,
      "concurrencyStamp": concurrencyStamp,
      "deviceId": deviceId,
    };
  }
}

class SetDeviceIdUsecase extends UseCase<CurrentUserModel, SetDeviceIdParams> {
  late final ConfigRepository repository;
  SetDeviceIdUsecase(this.repository);

  @override
  Future<Result<CurrentUserModel>> call({required SetDeviceIdParams params}) {
    return repository.setDeviceIdParamsRequest(params: params);
  }
}
