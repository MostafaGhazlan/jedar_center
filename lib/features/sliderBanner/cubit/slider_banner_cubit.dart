import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/sliderBanner/data/model/slider_banner_model.dart';
import 'package:meta/meta.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';
import '../data/repository/slider_banner_repository.dart';
import '../data/usecase/slider_banner_usecase.dart';
part 'slider_banner_state.dart';

class SliderBannerCubit extends Cubit<SliderBannerState> {
  PaginationCubit? productCubit;
  int totalResultCountSlider = 0;

  SliderBannerCubit() : super(ProductInitial());

  Future<Result> fetchSlider(data) async {
    Result<List<SliderBannerModel>> result =
        await ProductUsecase(SliderBannerRepository())
            .call(params: SliderBannerParams(request: data));

    if (result.hasDataOnly) {
      totalResultCountSlider = result.data?.length ?? 0;
    }
    emit(ProductLoaded());
    return result;
  }
}
