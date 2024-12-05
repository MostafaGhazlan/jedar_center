import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/product/data/model/product.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';
import '../repository/product_repository.dart';

class GetProductByMatrixParams extends BaseParams {
  final GetListRequest? request;
  final int matrixId;

  GetProductByMatrixParams({
    required this.request,
    required this.matrixId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetProductByMatrixUsecase
    extends UseCase<List<ProductModel>, GetProductByMatrixParams> {
  late final ProductRepository repository;
  GetProductByMatrixUsecase(this.repository);

  @override
  Future<Result<List<ProductModel>>> call(
      {required GetProductByMatrixParams params}) {
    return repository.productByMatrixRequest(params: params);
  }
}
