import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/matrix/data/usecase/get_matrix_by_category_usecase.dart';
import 'package:flutter_application_1/features/matrix/data/usecase/get_offers_usecase.dart';
import 'package:flutter_application_1/features/matrix/data/usecase/get_one_matrix_usecase.dart';
import 'package:flutter_application_1/features/product/data/model/product.dart';
import 'package:meta/meta.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/results/result.dart';
import '../data/model/matrix.dart';
import '../data/repository/matrix_repository.dart';
import '../data/usecase/get_all_usecase.dart';
import '../data/usecase/get_matrix_bt_brand_usecase.dart';
import '../data/usecase/get_most_sold_usecase.dart';

part 'matrix_state.dart';

class MatrixCubit extends Cubit<MatrixState> {
  PaginationCubit? matrixCubit;
  PaginationCubit? matrixCubit1;
  MatrixModel? matrix ;
  int selectedIndex = 0;

  int counter = 0;

  MatrixCubit() : super(MatrixInitial());

  Future<Result> fetchMostSoldMatrix(data) async {
    return await MostSoldUsecase(MatrixRepository())
        .call(params: MostSoldParams(request: data));
  }

  Future<Result> fetchOffersMatrix(data) async {
    return await OfferUsecase(MatrixRepository())
        .call(params: OfferParams(request: data));
  }

  Future<Result> fetchHomeMatrix(data) async {
    return await GetAllMAtrixUsecase(MatrixRepository())
        .call(params: GetAllMatrixParams(request: data));
  }

  Future<void> changeFavorite(ProductModel productModel) async {
  try {
    productModel.isLoading = true;
    emit(FavoritLoading());

    await CacheHelper.toggleWishList(productModel);

    productModel.isLoading = false;
    emit(MatrixInitial());
  } catch (e) {
    productModel.isLoading = false;
    emit(MatrixInitial());
  }
}


  zeroCounter() {
    emit(UpdateItemState());
  }

  incrementCounter() {
    counter++;
    emit(ChangeConterState());
  }

  decrimentCounter() {
    if (counter != 0) {
      counter--;
    }
    emit(ChangeConterState());
  }

  Future<Result> fetchMatrixByCategory(categoryId, data) async {
    return await GetMatrixByCategoryUsecase(MatrixRepository()).call(
        params:
            GetMatrixByCategoryParams(categoryId: categoryId, request: data));
  }

  Future<Result> fetchMatrixByBrand(brandId, data) async {
    return await GetMatrixByBrandUsecase(MatrixRepository()).call(
        params: GetMatrixByBrandParams(
      request: data,
      brandId: brandId,
    ));
  }

  Future<Result> fetchOneMatrix(matrixId) async {
    Result<MatrixModel> result =
        await GetOneMatrixUseCase(MatrixRepository()).call(
            params: GetOneMatrixParams(
      matrixId: matrixId,
    ));
    if (result.hasDataOnly) {
      matrix = result.data;
    }
    return result;
  }

 changeIndexDetails(index) {
    selectedIndex = index;
    emit(UpdateMatrixDetailsState());
  }

}
