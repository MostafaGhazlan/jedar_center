import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_application_1/features/orders/data/repoistory/order_repo.dart';
import '../../../../core/results/result.dart';

class CreateOrderParams extends BaseParams {
  String businessPartnerId;
  String phone1;
  String phone2;
  String address;
  String latitude;
  String longitude;
  int discountType;
  double discountTypeAmount;
  String note;
  List<OrderDetailParams> details;

  CreateOrderParams({
    required this.address,
    required this.businessPartnerId,
    required this.discountType,
    required this.discountTypeAmount,
    required this.latitude,
    required this.longitude,
    required this.note,
    required this.phone1,
    required this.phone2,
    required this.details,
  });

  toJson() {
    return {
      "address": address,
      "businessPartnerId": businessPartnerId,
      "discountType": discountType,
      "discountTypeAmount": discountTypeAmount,
      "latitude": latitude,
      "longitude": longitude,
      "note": note,
      "phone1": phone1,
      "phone2": phone2,
      "details": details.map((detail) => detail.toJson()).toList(),
    };
  }
}

class OrderDetailParams {
  String productId;
  int unitId;
  int pQty;
  int numPerMsr;
  double priceBefDis;
  int discountType;
  double discountTypeAmount;
  String note;

  OrderDetailParams({
    required this.productId,
    required this.unitId,
    required this.pQty,
    required this.numPerMsr,
    required this.priceBefDis,
    required this.discountType,
    required this.discountTypeAmount,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "unitId": unitId, //sUoMEntry
      "pQty": pQty, //quantity
      "numPerMsr": numPerMsr, //numInSale
      "priceBefDis": priceBefDis, //price1
      "discountType": discountType,
      "discountTypeAmount": discountTypeAmount,
      "note": note,
    };
  }
}

class CreateOrderUsecase extends UseCase<OrderModel, CreateOrderParams> {
  late final OrderRepository repository;
  CreateOrderUsecase(this.repository);

  @override
  Future<Result<OrderModel>> call({required CreateOrderParams params}) {
    return repository.createOrderRequest(params: params);
  }
}
