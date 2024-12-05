import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/features/search/data/usecase/auto_complete_search_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../core/variables/variables.dart';
import '../../../matrix/data/model/matrix.dart';
import '../model/auto_complete_model.dart';
import '../usecase/search_usecase.dart';

class SearchRepository extends CoreRepository {
  Future<Result<List<AutoCompleteModel>>> autoCompleteSearchRequest({
    required AutoCompleteSearchParams params,
  }) async {
    final result = await RemoteDataSource.request<List<AutoCompleteModel>>(
      withAuthentication: false,
      queryParameters: params.toJson(),
      url: autoCompleteUrl,
      method: HttpMethod.GET,
      responseStr: 'AutocompleteResponse',
      converter2: (p0) {
        return p0 == null
            ? []
            : List<AutoCompleteModel>.from(
                p0.map((x) => AutoCompleteModel.fromJson(x)));
      },
    );

    return call(result: result);
  }

  Future<Result<List<MatrixModel>>> searchRequest({
    required SearchParams params,
  }) async {
    final result = await RemoteDataSource.request<List<MatrixModel>>(
        withAuthentication: false,
        queryParameters: params.toJson(),
        url: searchUrl,
        method: HttpMethod.GET,
        responseStr: 'AutocompleteResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<MatrixModel>.from(
                  json["items"]!.map((x) => MatrixModel.fromJson(x)));
        });

    return call(result: result);
  }



}
