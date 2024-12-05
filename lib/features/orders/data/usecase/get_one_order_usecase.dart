import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/orders/data/repoistory/order_repo.dart';
import '../../../../core/results/result.dart';
import '../models/order_model.dart';

class GetOneOrderParams extends BaseParams {
  final int orderId;
  GetOneOrderParams({required this.orderId});
}

class GetOneOrderUseCase extends UseCase<OrderModel, GetOneOrderParams> {
  final OrderRepository repository;

  GetOneOrderUseCase(this.repository);

  @override
  Future<Result<OrderModel>> call({required GetOneOrderParams params}) {
    return repository.getOneOrderRequest(params: params);
  }
}
