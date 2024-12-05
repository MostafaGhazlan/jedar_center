import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_application_1/features/auth/data/usecase/register_usecase.dart';
import 'package:meta/meta.dart';
import '../../../core/results/result.dart';
import '../data/usecase/login_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool isObscure = true;
  LoginParams loginParams = LoginParams(
      username: '',
      password: '',
      grantType: 'password',
      clientId: 'MawaredApi_App',
      scope: 'profile offline_access email roles MawaredApi');
  RegisterParams registerParams = RegisterParams(
      username: "",
      password: "",
      address: "",
      email: "",
      latitude: "",
      longitude: "",
      mobile: "",
      name: "",
      phoneNumber: "",
      secondAddress: "",
      surname: "");



  changeObscurePassword() {
    isObscure = !isObscure;
    emit(UpdateAuthState());
  }
 
  Future<Result> login() async {
    return LoginUsecase(AuthRepository()).call(params: loginParams);
  }

 

  Future<Result> sigup() async {
    return RegisterUsecase(AuthRepository()).call(params: registerParams);
  }
}
