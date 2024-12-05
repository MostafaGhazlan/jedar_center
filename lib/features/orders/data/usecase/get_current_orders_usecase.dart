import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_application_1/features/orders/data/repoistory/order_repo.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';

class GetCurrentOrdersParams extends BaseParams {
  final GetListRequest? request;

  GetCurrentOrdersParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) data.addAll(request!.toJson());
    return data;
  }
}

class GetCurrentOrdersUsecase
    extends UseCase<List<OrderModel>, GetCurrentOrdersParams> {
  late final OrderRepository repository;
  GetCurrentOrdersUsecase(this.repository);

  @override
  Future<Result<List<OrderModel>>> call({required GetCurrentOrdersParams params}) {
    return repository.getCurrentOrdersRequest(params: params);
  }
}
