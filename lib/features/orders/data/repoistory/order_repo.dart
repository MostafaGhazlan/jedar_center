import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_application_1/features/orders/data/usecase/create_order_usecase.dart';
import 'package:flutter_application_1/features/orders/data/usecase/get_current_orders_usecase.dart';
import 'package:flutter_application_1/features/orders/data/usecase/get_previous_order_usecase.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/repository/core_repository.dart';
import '../../../../core/results/result.dart';
import '../../../../core/variables/variables.dart';
import '../usecase/get_one_order_usecase.dart';

class OrderRepository extends CoreRepository {
  Future<Result<OrderModel>> createOrderRequest(
      {required CreateOrderParams params}) async {
    final result = await RemoteDataSource.request<OrderModel>(
        withAuthentication: true,
        data: params.toJson(),
        url: createOrderUrl,
        method: HttpMethod.POST,
        responseStr: 'CreateOrderResponse',
        converter: (json) {
          return OrderModel.fromJson(json);
        });

    return call(result: result);
  }

  Future<Result<List<OrderModel>>> getCurrentOrdersRequest(
      {required GetCurrentOrdersParams params}) async {
    final result = await RemoteDataSource.request<List<OrderModel>>(
        withAuthentication: true,
        data: params.toJson(),
        queryParameters: params.toJson(),
        url: currentOrdersUrl,
        method: HttpMethod.GET,
        responseStr: 'CurrentOrderResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<OrderModel>.from(
                  json["items"]!.map((x) => OrderModel.fromJson(x)));
        });

    return call(result: result);
  }

  Future<Result<List<OrderModel>>> getPreviousOrdersRequest(
      {required GetPreviousOrdersParams params}) async {
    final result = await RemoteDataSource.request<List<OrderModel>>(
        withAuthentication: true,
        data: params.toJson(),
        queryParameters: params.toJson(),
        url: previousOrdersUrl,
        method: HttpMethod.GET,
        responseStr: 'PreviousOrdersResponse',
        converter: (json) {
          totalResultCount = json["totalCount"];
          return json["items"] == null
              ? []
              : List<OrderModel>.from(
                  json["items"]!.map((x) => OrderModel.fromJson(x)));
        });

    return call(result: result);
  }

  Future<Result<OrderModel>> getOneOrderRequest(
      {required GetOneOrderParams params}) async {
    final result = await RemoteDataSource.request<OrderModel>(
        withAuthentication: true,
        url: '$oneOrderUrl/${params.orderId}',
        method: HttpMethod.GET,
        responseStr: 'OneOrderResponse',
        converter: (json) => OrderModel.fromJson(json));

    return call(result: result);
  }
}
