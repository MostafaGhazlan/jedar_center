import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/features/cart/data/repoisotry/cart_repo.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import '../../../../../core/results/result.dart';

class PromoCodeParams extends BaseParams {
  String businessPartnerId;
  String phone1;                           
  String phone2;
  String address;
  String latitude;
  String longitude;
  String docPromoCode;
  int discountType;
  double discountTypeAmount;
  String note;
  List<PromoCodeDetailParams> details;

  PromoCodeParams({
    required this.address,
    required this.businessPartnerId,
    required this.discountType,
    required this.discountTypeAmount,
    required this.latitude,
    required this.longitude,
    required this.note,
    required this.phone1,
    required this.phone2,
    required this.docPromoCode,
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
      "docPromoCode": docPromoCode,
      "phone1": phone1,
      "phone2": phone2,
      "details": details.map((detail) => detail.toJson()).toList(),
    };
  }
}

class PromoCodeDetailParams {
  String productId;
  int unitId;
  int pQty;
  int numPerMsr;
  double priceBefDis;
  int discountType;
  double discountTypeAmount;
  String note;

  PromoCodeDetailParams({
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

class PromoCodeUsecase extends UseCase<OrderModel, PromoCodeParams> {
  late final CartRepository repository;
  PromoCodeUsecase(this.repository);

  @override
  Future<Result<OrderModel>> call({required PromoCodeParams params}) {
    return repository.promoCodeRequest(params: params);
  }
}
