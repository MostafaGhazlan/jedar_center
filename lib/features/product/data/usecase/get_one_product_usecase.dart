import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/product/data/model/product.dart';
import '../../../../core/results/result.dart';
import '../repository/product_repository.dart';

class GetOneProductParams extends BaseParams {
  final String productId;

  GetOneProductParams({
    required this.productId,
  });
}

class GetOneProductUsecase
    extends UseCase<ProductModel, GetOneProductParams> {
  late final ProductRepository repository;
  GetOneProductUsecase(this.repository);

  @override
  Future<Result<ProductModel>> call(
      {required GetOneProductParams params}) {
    return repository.oneProductRequest(params: params);
  }
}
