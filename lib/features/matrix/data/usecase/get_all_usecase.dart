import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/matrix/data/repository/matrix_repository.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class GetAllMatrixParams extends BaseParams {
  final GetListRequest? request;

  GetAllMatrixParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetAllMAtrixUsecase
    extends UseCase<List<MatrixModel>, GetAllMatrixParams> {
  late final MatrixRepository repository;
  GetAllMAtrixUsecase(this.repository);

  @override
  Future<Result<List<MatrixModel>>> call({required GetAllMatrixParams params}) {
    return repository.allRequest(params: params);
  }
}
