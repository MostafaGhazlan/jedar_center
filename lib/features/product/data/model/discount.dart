import 'package:hive_flutter/hive_flutter.dart';

part 'discount.g.dart';

@HiveType(typeId: 4)
class DiscountModel {
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? discountName;
  @HiveField(3)
  String? discountCode;
  @HiveField(4)
  int? discountType;
  @HiveField(5)
  double? discountValue;

  DiscountModel(
      {this.id,
      this.discountName,
      this.discountCode,
      this.discountType,
      this.discountValue});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountName = json['discountName'];
    discountCode = json['discountCode'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'discountName': discountName,
      'discountCode': discountCode,
      'discountType': discountType,
      'discountValue': discountValue,
    };
  }
}
