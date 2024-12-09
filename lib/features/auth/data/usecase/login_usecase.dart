import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/auth/data/model/login_model.dart';
import 'package:flutter_application_1/features/auth/data/repository/auth_repository.dart';

import '../../../../core/results/result.dart';

class LoginParams extends BaseParams {
  String username;
  String password;
  String grantType;
  String clientId;
  String scope;

  LoginParams({
    required this.username,
    required this.password,
    required this.grantType,
    required this.clientId,
    required this.scope,
  });
  toJson() {
    return {
      "username": username.trim(),
      "password": password.trim(),
      "grant_type": grantType,
      "client_id": clientId,
      "scope": scope,
    };
  }
}

class LoginUsecase extends UseCase<LoginModel, LoginParams> {
  late final AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  Future<Result<LoginModel>> call({required LoginParams params}) {
    return repository.loginRequest(params: params);
  }
}
