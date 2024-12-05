import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/core/variables/variables.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/matrix/data/usecase/get_all_usecase.dart';
import 'package:flutter_application_1/features/matrix/data/usecase/get_most_sold_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../usecase/get_matrix_bt_brand_usecase.dart';
import '../usecase/get_matrix_by_category_usecase.dart';
import '../usecase/get_offers_usecase.dart';
import '../usecase/get_one_matrix_usecase.dart';

class MatrixRepository extends CoreRepository {
  Future<Result<List<MatrixModel>>> mostSoldRequest(
      {required MostSoldParams params}) async {
    final result = await RemoteDataSource.request<List<MatrixModel>>(
        withAuthentication: false,
        url: mostSoldMatrixUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'MostSoldResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<MatrixModel>.from(
                  json["items"]!.map((x) => MatrixModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<List<MatrixModel>>> offerRequest(
      {required OfferParams params}) async {
    final result = await RemoteDataSource.request<List<MatrixModel>>(
        withAuthentication: false,
        url: offerMatrixUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'OfferResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<MatrixModel>.from(
                  json["items"]!.map((x) => MatrixModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<List<MatrixModel>>> allRequest(
      {required GetAllMatrixParams params}) async {
    final result = await RemoteDataSource.request<List<MatrixModel>>(
        withAuthentication: false,
        url: allMatrixUrl,
        queryParameters: params.toJson(),
        method: HttpMethod.GET,
        responseStr: 'AllResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<MatrixModel>.from(
                  json["items"]!.map((x) => MatrixModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<List<MatrixModel>>> matrixByCategoruRequest(
      {required GetMatrixByCategoryParams params}) async {
    final result = await RemoteDataSource.request<List<MatrixModel>>(
        withAuthentication: false,
        queryParameters: params.toJson(),
        url: "$matrixByCategoryUrl/${params.categoryId}",
        method: HttpMethod.GET,
        responseStr: 'AllResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<MatrixModel>.from(
                  json["items"]!.map((x) => MatrixModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<List<MatrixModel>>> matrixByBrandRequest(
      {required GetMatrixByBrandParams params}) async {
    final result = await RemoteDataSource.request<List<MatrixModel>>(
        withAuthentication: false,
        queryParameters: params.toJson(),
        url: "$matrixByBrandUrl/${params.brandId}",
        method: HttpMethod.GET,
        responseStr: 'AllResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<MatrixModel>.from(
                  json["items"]!.map((x) => MatrixModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<MatrixModel>> getOneMatrixRequest(
      {required GetOneMatrixParams params}) async {
    final result = await RemoteDataSource.request<MatrixModel>(
        withAuthentication: true,
        url: '$allMatrixUrl/${params.matrixId}',
        method: HttpMethod.GET,
        responseStr: 'OneMatrixResponse',
        converter: (json) => MatrixModel.fromJson(json));

    return call(result: result);
  }

}
