import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_application_1/features/orders/data/repoistory/order_repo.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class GetPreviousOrdersParams extends BaseParams {
  final GetListRequest? request;

  GetPreviousOrdersParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetPreviousOrdersUsecase
    extends UseCase<List<OrderModel>, GetPreviousOrdersParams> {
  late final OrderRepository repository;
  GetPreviousOrdersUsecase(this.repository);

  @override
  Future<Result<List<OrderModel>>> call({required GetPreviousOrdersParams params}) {
    return repository.getPreviousOrdersRequest(params: params);
  }
}
