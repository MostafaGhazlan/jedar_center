import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import '../../../../core/results/result.dart';
import '../repository/category_repository.dart';

class CategoryAndFamilyParams extends BaseParams {
  final String categoryId;

  CategoryAndFamilyParams({required this.categoryId});
}

class CategoryAndFamilyUsecase
    extends UseCase<CategoryModel, CategoryAndFamilyParams> {
  late final CategoryRepository repository;
  CategoryAndFamilyUsecase(this.repository);

  @override
  Future<Result<CategoryModel>> call(
      {required CategoryAndFamilyParams params}) {
    return repository.categoryAndFamily(params: params);
  }
}
