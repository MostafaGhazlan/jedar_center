import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/sliderBanner/data/model/slider_banner_model.dart';
import 'package:flutter_application_1/features/sliderBanner/data/repository/slider_banner_repository.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class SliderBannerParams extends BaseParams {
  final GetListRequest? request;

  SliderBannerParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class ProductUsecase
    extends UseCase<List<SliderBannerModel>, SliderBannerParams> {
  late final SliderBannerRepository repository;
  ProductUsecase(this.repository);

  @override
  Future<Result<List<SliderBannerModel>>> call(
      {required SliderBannerParams params}) {
    return repository.productRequest(params: params);
  }
}
