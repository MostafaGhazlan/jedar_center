import 'package:hive/hive.dart';

part 'product_price_model.g.dart';

@HiveType(typeId: 6) 
class ProductPriceModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  double? price;

  @HiveField(2)
  String? curr;

  @HiveField(3)
  double? addPrice1;

  @HiveField(4)
  String? curr1;

  @HiveField(5)
  double? addPrice2;

  @HiveField(6)
  String? curr2;

  ProductPriceModel({
    this.id,
    this.price,
    this.curr,
    this.addPrice1,
    this.curr1,
    this.addPrice2,
    this.curr2,
  });

  ProductPriceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    curr = json['curr'];
    addPrice1 = json['addPrice1'];
    curr1 = json['curr1'];
    addPrice2 = json['addPrice2'];
    curr2 = json['curr2'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'curr': curr,
      'addPrice1': addPrice1,
      'curr1': curr1,
      'addPrice2': addPrice2,
      'curr2': curr2,
    };
  }
}
