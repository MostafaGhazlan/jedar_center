import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/brand/data/model/brand.dart';
import 'package:flutter_application_1/features/brand/data/repository/brand_repository.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class BrandParams extends BaseParams {
  final GetListRequest? request;

  BrandParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class BrandUsecase
    extends UseCase<List<BrandModel>, BrandParams> {
  late final BrandRepository repository;
  BrandUsecase(this.repository);

  @override
  Future<Result<List<BrandModel>>> call(
      {required BrandParams params}) {
    return repository.brandRequest(params: params);
  }
}
