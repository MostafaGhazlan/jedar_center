import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import '../../../../core/results/result.dart';
import '../model/auto_complete_model.dart';
import '../repositiory/search_repositiory.dart';

class AutoCompleteSearchParams extends BaseParams {
  String? term;

  AutoCompleteSearchParams({this.term});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data.addAll({
      "Term": term,
    });

    return data;
  }
}

class AutoCompleteSearchUsecase
    extends UseCase<List<AutoCompleteModel>, AutoCompleteSearchParams> {
  late final SearchRepository repository;
  AutoCompleteSearchUsecase(this.repository);

  @override
  Future<Result<List<AutoCompleteModel>>> call(
      {required AutoCompleteSearchParams params}) {
    return repository.autoCompleteSearchRequest(params: params);
  }
}
