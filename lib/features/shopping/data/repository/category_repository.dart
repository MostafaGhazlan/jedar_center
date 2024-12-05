import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/core/variables/variables.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import 'package:flutter_application_1/features/shopping/data/usecase/all_category_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../usecase/all_category_for_search_usecase.dart';
import '../usecase/category_and_family_usecase.dart';

class CategoryRepository extends CoreRepository {
  Future<Result<List<CategoryModel>>> allCategory(
      {required AllCategoryParams params}) async {
    final result = await RemoteDataSource.request<List<CategoryModel>>(
        withAuthentication: false,
        url: allCategoryUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'AllResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<CategoryModel>.from(
                  json["items"]!.map((x) => CategoryModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<CategoryModel>> categoryAndFamily(
      {required CategoryAndFamilyParams params}) async {
    final result = await RemoteDataSource.request<CategoryModel>(
        withAuthentication: false,
        url: "$categoryAndFamilyUrl/${params.categoryId}",
        method: HttpMethod.GET,
        responseStr: 'CategoryAndFamilyResponse',
        converter: (json) => CategoryModel.fromJson(json));
    return call(result: result);
  }

    Future<Result<List<CategoryModel>>> allCategoryForSearch(
      {required AllCategoryForSearchParams params}) async {
    final result = await RemoteDataSource.request<List<CategoryModel>>(
        withAuthentication: false,
        url: allCategoryForSearchUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'AllResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<CategoryModel>.from(
                  json["items"]!.map((x) => CategoryModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }
}
