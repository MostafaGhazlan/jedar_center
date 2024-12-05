import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/product/data/repository/product_repository.dart';
import 'package:flutter_application_1/features/product/data/usecase/get_one_product_usecase.dart';
import 'package:flutter_application_1/features/product/data/usecase/get_product_by_matrix_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/boilerplate/get_model/cubits/get_model_cubit.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  PaginationCubit? productCubit;
  GetModelCubit? getModelCubit;

  String selectId = "";
  ProductCubit() : super(ProductInitial());

  Future<Result> fetchProductByMatrix(matrixId, data) async {
    return await GetProductByMatrixUsecase(ProductRepository()).call(
        params: GetProductByMatrixParams(matrixId: matrixId, request: data));
  }

  Future<Result> fetchOneProduct(productId) async {
    return await GetOneProductUsecase(ProductRepository())
        .call(params: GetOneProductParams(productId: productId));
  }
}
