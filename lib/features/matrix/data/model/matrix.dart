import 'package:hive_flutter/hive_flutter.dart';
import '../../../product/data/model/product.dart';

part 'matrix.g.dart';

@HiveType(typeId: 0)
class MatrixModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? matrixName;
  @HiveField(2)
  String? matrixNameEn;
  @HiveField(3)
  String? imageName;
  @HiveField(4)
  String? categoryId;
  @HiveField(5)
  int? matrixTypeId;
  @HiveField(6)
  String? notes;
  @HiveField(7)
  String? info;
  @HiveField(8)
  int? productCount;
  @HiveField(9)
  List<ProductModel>? products;

  MatrixModel({
    this.id,
    this.matrixName,
    this.matrixNameEn,
    this.imageName,
    this.categoryId,
    this.matrixTypeId,
    this.notes,
    this.info,
    this.productCount,
    this.products,
  });

  MatrixModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matrixName = json['matrixName'];
    matrixNameEn = json['matrixNameEn'];
    imageName = json['imageName'];
    categoryId = json['categoryId'];
    matrixTypeId = json['matrixTypeId'];
    notes = json['notes'];
    info = json['info'];
    productCount = json['productCount'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'MatrixModel{id: $id, matrixName: $matrixName, matrixNameEn: $matrixNameEn, imageName: $imageName, categoryId: $categoryId, matrixTypeId: $matrixTypeId, notes: $notes, info: $info, productCount: $productCount, product: $products}';
  }
}
