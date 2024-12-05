import 'package:flutter_application_1/core/repository/core_repository.dart';
import 'package:flutter_application_1/core/variables/variables.dart';
import 'package:flutter_application_1/features/product/data/model/product.dart';
import 'package:flutter_application_1/features/product/data/usecase/get_one_product_usecase.dart';
import 'package:flutter_application_1/features/product/data/usecase/get_product_by_matrix_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';

class ProductRepository extends CoreRepository {
  Future<Result<List<ProductModel>>> productByMatrixRequest(
      {required GetProductByMatrixParams params}) async {
    final result = await RemoteDataSource.request<List<ProductModel>>(
        withAuthentication: false,
        queryParameters: params.toJson(),
        url: "$productByMatrixUrl/${params.matrixId}",
        method: HttpMethod.GET,
        responseStr: 'ProductByMatrixResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<ProductModel>.from(
                  json["items"]!.map((x) => ProductModel.fromJson(x)));
        });

    return paginatedCall(result: result);
  }

  Future<Result<ProductModel>> oneProductRequest(
      {required GetOneProductParams params}) async {
    final result = await RemoteDataSource.request<ProductModel>(
        withAuthentication: false,
        url: "$oneProductUrl/${params.productId}",
        method: HttpMethod.GET,
        responseStr: 'OneProductResponse',
        converter: (json) => ProductModel.fromJson(json));
    return call(result: result);
  }
}
