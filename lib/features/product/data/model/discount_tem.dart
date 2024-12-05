import 'discount.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'discount_tem.g.dart';

@HiveType(typeId: 3)
class DiscountIIemModel {
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? productId;
  @HiveField(3)
  int? sDiscountId;
  @HiveField(4)
  DiscountModel? discount;
  @HiveField(5)
  int? discountType;
  @HiveField(6)
  int? discountValue;

  DiscountIIemModel({this.id, this.productId, this.sDiscountId, this.discount});

  DiscountIIemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    sDiscountId = json['sDiscountId'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    discount = json['discount'] != null
        ? DiscountModel.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'sDiscountId': sDiscountId,
      'discountType': discountType,
      'discountValue': discountValue,
      'discount': discount?.toJson(),
    };
  }
}
