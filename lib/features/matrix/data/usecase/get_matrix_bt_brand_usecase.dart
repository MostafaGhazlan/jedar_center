import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/matrix/data/repository/matrix_repository.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class GetMatrixByBrandParams extends BaseParams {
  final GetListRequest? request;
  final String brandId;

  GetMatrixByBrandParams({
    required this.request,
    required this.brandId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetMatrixByBrandUsecase
    extends UseCase<List<MatrixModel>, GetMatrixByBrandParams> {
  late final MatrixRepository repository;
  GetMatrixByBrandUsecase(this.repository);

  @override
  Future<Result<List<MatrixModel>>> call(
      {required GetMatrixByBrandParams params}) {
    return repository.matrixByBrandRequest(params: params);
  }
}
