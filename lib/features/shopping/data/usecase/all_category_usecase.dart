import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';
import '../repository/category_repository.dart';

class AllCategoryParams extends BaseParams {
  final GetListRequest? request;

  AllCategoryParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class AllCategoryUsecase
    extends UseCase<List<CategoryModel>, AllCategoryParams> {
  late final CategoryRepository repository;
  AllCategoryUsecase(this.repository);

  @override
  Future<Result<List<CategoryModel>>> call({required AllCategoryParams params}) {
    return repository.allCategory(params: params);
  }
}
