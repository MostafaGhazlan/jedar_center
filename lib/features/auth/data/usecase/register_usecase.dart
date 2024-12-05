import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/auth/data/model/register_model.dart';
import 'package:flutter_application_1/features/auth/data/repository/auth_repository.dart';

import '../../../../core/results/result.dart';

class RegisterParams extends BaseParams {
  String username;
  String password;
  String email;
  String name;
  String surname;
  String phoneNumber;
  String mobile;
  String address;
  String secondAddress;
  String latitude;
  String longitude;

  RegisterParams({
    required this.username,
    required this.password,
    required this.address,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.mobile,
    required this.name,
    required this.phoneNumber,
    required this.secondAddress,
    required this.surname,
  });
  toJson() {
    return {
      "username": username.trim(),
      "password": password.trim(),
      "email": email,
      "name": name,
      "surname": surname,
      "mobile": mobile,
      "phoneNumber": phoneNumber,
      "address": address,
      "secondAddress": secondAddress,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

class RegisterUsecase extends UseCase<RegisterModel, RegisterParams> {
  late final AuthRepository repository;
  RegisterUsecase(this.repository);

  @override
  Future<Result<RegisterModel>> call({required RegisterParams params}) {
    return repository.registerRequest(params: params);
  }
}
