import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../results/result.dart';

abstract class CoreRepository {
  Result<Model> call<Model>({required Either<String, Model> result}) {
    if (kDebugMode) {
      print('in core repository : ${result.isRight()}');
    }
    if (result.isRight()) {
      return RemoteResult(data: (result as Right).value,);
    } else {
      return RemoteResult(
        error: (result as Left).value,
      );
    }
  }

  Result<List<Model>> paginatedCall<Model>({required Either<String, List<Model>> result}) {
    if (kDebugMode) {
      print('in core repository : ${result.isRight()}');
    }
    if (result.isRight()) {
      return PaginatedResult(
        data: (result as Right).value,
      );
    } else {
      return RemoteResult(
        error: (result as Left).value,
      );
    }
  }

  Result<String> noModelCall({required Either<String, dynamic> result}) {
    if (kDebugMode) {
      print('in core repository : ${result.isRight()}');
    }
    if (result.isRight()) {
      return Result(data: (result as Right).value);
    } else {
      return RemoteResult(
        error: (result as Left).value,
      );
    }
  }

}
