import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';
import '../data/repository/brand_repository.dart';
import '../data/usecase/brand_usecase.dart';
import '../data/usecase/get_brand_by_category_usecase.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  PaginationCubit? brandCubit;
  String? selectedCategoryId;

  BrandCubit() : super(BrandInitial());

  Future<Result> fetchAllBrand(data) async {
    return await BrandUsecase(BrandRepository())
        .call(params: BrandParams(request: data));
  }

  Future<Result> fetchHomeBrand(data) async {
    return await BrandUsecase(BrandRepository())
        .call(params: BrandParams(request: data));
  }

  Future<Result> fetchMatrixByCategory(categoryId, data) async {
    return await GetBrandByCategoryUsecase(BrandRepository()).call(
        params:
            GetBrandByCategoryParams(categoryId: categoryId, request: data));
  }
}
