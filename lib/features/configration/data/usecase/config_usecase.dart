import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/configration/data/repository/config_repo.dart';

import '../../../../core/results/result.dart';
import '../model/config_model.dart';

class ConfigParams extends BaseParams {}

class ConfigUsecase extends UseCase<CurrentUserModel, ConfigParams> {
  late final ConfigRepository repository;
  ConfigUsecase(this.repository);

  @override
  Future<Result<CurrentUserModel>> call({required ConfigParams params}) {
    return repository.currentUserRequest(params: params);
  }
}
