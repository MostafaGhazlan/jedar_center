import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/boilerplate/get_model/cubits/get_model_cubit.dart';
import '../../../main.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  bool oldObscure = true;
  bool newObscure = true;
  bool confirmObscure = true;
  Locale initiallang = const Locale("ar");
  GetModelCubit? getAddressCubit;

  ProfileCubit()
      : initiallang = _getInitialLocale(),
        super(ProfileInitialState());

  static Locale _getInitialLocale() {
    final lang = prefs?.getString("lang") ?? "ar";
    return lang == "en" ? const Locale("en") : const Locale("ar");
  }



  changeOldObscurePassword() {
    oldObscure = !oldObscure;
    emit(UpdateChangePasswordState());
  }

  changeNewObscurePassword() {
    newObscure = !newObscure;
    emit(UpdateChangePasswordState());
  }

  changeConfirmObscurePassword() {
    confirmObscure = !confirmObscure;
    emit(UpdateChangePasswordState());
  }

  updateStates() {
    emit(UpdateState());
  }

  clearPassword() {
    oldObscure = true;
    newObscure = true;
    confirmObscure = true;
  }

  Future<void> changeLang(String codeLang) async {
    await prefs?.setString("lang", codeLang);
    initiallang = codeLang == "en" ? const Locale("en") : const Locale("ar");
    emit(UpdateChangeLanguageState());
  }
}
