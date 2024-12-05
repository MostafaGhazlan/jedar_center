import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/core/variables/variables.dart';
import 'package:flutter_application_1/features/brand/data/model/brand.dart';
import 'package:flutter_application_1/features/brand/data/usecase/brand_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../usecase/get_brand_by_category_usecase.dart';

class BrandRepository extends CoreRepository {
  Future<Result<List<BrandModel>>> brandRequest(
      {required BrandParams params}) async {
    final result = await RemoteDataSource.request<List<BrandModel>>(
        withAuthentication: false,
        url: brandUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'BrandResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<BrandModel>.from(
                  json["items"]!.map((x) => BrandModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<List<BrandModel>>> brandByCategoryRequest(
      {required GetBrandByCategoryParams params}) async {
    final result = await RemoteDataSource.request<List<BrandModel>>(
        withAuthentication: false,
        url: "$brandByCategoryUrl/${params.categoryId}",
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'GetBrandByCategoryResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<BrandModel>.from(
                  json["items"]!.map((x) => BrandModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }
}
