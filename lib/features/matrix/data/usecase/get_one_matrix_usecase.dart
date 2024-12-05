import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/matrix/data/model/matrix.dart';
import 'package:flutter_application_1/features/matrix/data/repository/matrix_repository.dart';
import '../../../../core/results/result.dart';

class GetOneMatrixParams extends BaseParams {
  final int matrixId;
  GetOneMatrixParams({required this.matrixId});
}

class GetOneMatrixUseCase extends UseCase<MatrixModel, GetOneMatrixParams> {
  final MatrixRepository repository;

  GetOneMatrixUseCase(this.repository);

  @override
  Future<Result<MatrixModel>> call({required GetOneMatrixParams params}) {
    return repository.getOneMatrixRequest(params: params);
  }
}
