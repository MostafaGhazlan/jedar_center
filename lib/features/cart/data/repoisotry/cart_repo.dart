import 'package:flutter_application_1/features/cart/data/usecase/promo_code_usecase.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import '../../../../core/constant/end_points/api_url.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/repository/core_repository.dart';
import '../../../../core/results/result.dart';

class CartRepository extends CoreRepository {
  Future<Result<OrderModel>> promoCodeRequest(
      {required PromoCodeParams params}) async {
    final result = await RemoteDataSource.request<OrderModel>(
        withAuthentication: true,
        data: params.toJson(),
        url: promoCodeUrl,
        method: HttpMethod.POST,
        responseStr: 'PromoCodeResponse',
        converter: (json) {
          return OrderModel.fromJson(json);
        });

    return call(result: result);
  }

  
}
