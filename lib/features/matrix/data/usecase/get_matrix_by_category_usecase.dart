import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/matrix/data/repository/matrix_repository.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class GetMatrixByCategoryParams extends BaseParams {
  final GetListRequest? request;
  final String categoryId;

  GetMatrixByCategoryParams({
    required this.request,
    required this.categoryId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetMatrixByCategoryUsecase
    extends UseCase<List<MatrixModel>, GetMatrixByCategoryParams> {
  late final MatrixRepository repository;
  GetMatrixByCategoryUsecase(this.repository);

  @override
  Future<Result<List<MatrixModel>>> call(
      {required GetMatrixByCategoryParams params}) {
    return repository.matrixByCategoruRequest(params: params);
  }
}
