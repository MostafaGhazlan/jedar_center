import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';
import '../repository/category_repository.dart';

class AllCategoryForSearchParams extends BaseParams {
  final GetListRequest? request;

  AllCategoryForSearchParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class AllCategoryForSearchUsecase
    extends UseCase<List<CategoryModel>, AllCategoryForSearchParams> {
  late final CategoryRepository repository;
  AllCategoryForSearchUsecase(this.repository);

  @override
  Future<Result<List<CategoryModel>>> call({required AllCategoryForSearchParams params}) {
    return repository.allCategoryForSearch(params: params);
  }
}
