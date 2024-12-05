import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/features/auth/data/model/login_model.dart';
import 'package:flutter_application_1/features/auth/data/model/register_model.dart';
import 'package:flutter_application_1/features/auth/data/usecase/login_usecase.dart';
import 'package:flutter_application_1/features/auth/data/usecase/register_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../usecase/refresh_token_usecase.dart';

class AuthRepository extends CoreRepository {
  Future<Result<LoginModel>> loginRequest({required LoginParams params}) async {
    final result = await RemoteDataSource.request<LoginModel>(
        contentType: 'application/x-www-form-urlencoded',
        withAuthentication: false,
        data: params.toJson(),
        url: loginUrl,
        method: HttpMethod.POST,
        responseStr: 'LoginResponse',
        converter: (json) {
          return LoginModel.fromJson(json);
        });

    return call(result: result);
  }

  Future<Result<LoginModel>> refreshTokenRequest(
      {required RefreshTokenParams params}) async {
    final result = await RemoteDataSource.request<LoginModel>(
        contentType: 'application/x-www-form-urlencoded',
        withAuthentication: false,
        data: params.toJson(),
        url: loginUrl,
        method: HttpMethod.POST,
        responseStr: 'RefreshTokenResponse',
        converter: (json) {
          return LoginModel.fromJson(json);
        });

    return call(result: result);
  }

  Future<Result<RegisterModel>> registerRequest(
      {required RegisterParams params}) async {
    final result = await RemoteDataSource.request<RegisterModel>(
        withAuthentication: false,
        data: params.toJson(),
        url: registerUrl,
        method: HttpMethod.POST,
        responseStr: 'RegisterResponse',
        converter: (json) {
          return RegisterModel.fromJson(json);
        });

    return call(result: result);
  }
}
