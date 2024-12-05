import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/core/variables/variables.dart';
import 'package:flutter_application_1/features/sliderBanner/data/model/slider_banner_model.dart';
import 'package:flutter_application_1/features/sliderBanner/data/usecase/slider_banner_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';

class SliderBannerRepository extends CoreRepository {
  Future<Result<List<SliderBannerModel>>> productRequest(
      {required SliderBannerParams params}) async {
    final result = await RemoteDataSource.request<List<SliderBannerModel>>(
        withAuthentication: false,
        url: sliderBannerUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'ProductResponse',
        converter: (json) {
          totalResultCountSlider = json["totalCount"];
          return json["items"] == null
              ? []
              : List<SliderBannerModel>.from(
                  json["items"]!.map((x) => SliderBannerModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }
}
