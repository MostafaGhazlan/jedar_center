import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/configration/data/repository/config_repo.dart';
import 'package:meta/meta.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/results/result.dart';
import '../data/model/config_model.dart';
import '../data/usecase/config_usecase.dart';
import '../data/usecase/set_decive_id_usecase.dart';
part 'configration_state.dart';

class ConfigrationCubit extends Cubit<ConfigrationState> {
  ConfigrationCubit() : super(ConfigrationInitial());
  SetDeviceIdParams setDeviceIdParams =
      SetDeviceIdParams(userId: "", concurrencyStamp: "", deviceId: "");

  Future<Result> config() async {
    Result<CurrentUserModel> result =
        await ConfigUsecase(ConfigRepository()).call(params: ConfigParams());

    if (result.hasDataOnly) {

      await CacheHelper.setCurrentUserInfo(result.data);

    }

    return result;
  }

  Future<Result> setDeviceId() async {
    return SetDeviceIdUsecase(ConfigRepository())
        .call(params: setDeviceIdParams);
  }
}
