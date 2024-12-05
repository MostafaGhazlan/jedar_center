import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/brand/data/model/brand.dart';
import 'package:flutter_application_1/features/brand/data/repository/brand_repository.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class GetBrandByCategoryParams extends BaseParams {
  final GetListRequest? request;
  final String categoryId;

  GetBrandByCategoryParams({required this.request, required this.categoryId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetBrandByCategoryUsecase
    extends UseCase<List<BrandModel>, GetBrandByCategoryParams> {
  late final BrandRepository repository;
  GetBrandByCategoryUsecase(this.repository);

  @override
  Future<Result<List<BrandModel>>> call(
      {required GetBrandByCategoryParams params}) {
    return repository.brandByCategoryRequest(params: params);
  }
}
