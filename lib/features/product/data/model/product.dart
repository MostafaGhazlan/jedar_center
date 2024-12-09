import 'dart:convert';

import 'package:flutter_application_1/features/brand/data/model/brand.dart';
import 'package:flutter_application_1/features/product/data/model/discount_tem.dart';
import 'package:flutter_application_1/features/product/data/model/suom_model.dart';
import 'package:flutter_application_1/features/shopping/data/model/category.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../sliderBanner/data/model/document_model.dart';
import 'product_price_model.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? productName;
  @HiveField(2)
  String? productNameEn;
  @HiveField(3)
  String? barcode;
  @HiveField(4)
  String? modelNo;
  @HiveField(5)
  String? partNo;
  @HiveField(6)
  String? description;
  @HiveField(7)
  String? productColor;
  @HiveField(8)
  String? hexColorCode;
  @HiveField(9)
  String? productSize;
  @HiveField(10)
  String? categoryId;
  @HiveField(11)
  CategoryModel? category;
  @HiveField(12)
  String? brandId;
  @HiveField(13)
  BrandModel? brand;
  @HiveField(14)
  double? matrixId; 
  @HiveField(15)
  double? sUoMEntry;
  @HiveField(16)
  SUoMModel? sUoM;
  @HiveField(17)
  double? numInSale; 
  @HiveField(18)
  double? stockQty; 
  @HiveField(19)
  double? price; 
  @HiveField(20)
  String? priceCurrencyCode;
  @HiveField(21)
  double? price1; 
  @HiveField(22)
  String? price1CurrencyCode;
  @HiveField(23)
  double? price11; 
  @HiveField(24)
  String? price1CurrencyCode1;
  @HiveField(25)
  double? price12; 
  @HiveField(26)
  String? price1CurrencyCode2;
  @HiveField(27)
  ProductPriceModel? productPrice;
  @HiveField(28)
  DiscountIIemModel? discountItem;
  @HiveField(29)
  List<DocumentModel>? documents;
  @HiveField(30)
  int quantity;  
  @HiveField(31)
  bool isFavorite = false; 
  @HiveField(32)
  bool isLoading = false; 

  ProductModel({
    this.id,
    this.productName,
    this.productNameEn,
    this.barcode,
    this.modelNo,
    this.partNo,
    this.description,
    this.productColor,
    this.hexColorCode,
    this.productSize,
    this.categoryId,
    this.category,
    this.brandId,
    this.brand,
    this.matrixId,
    this.sUoMEntry,
    this.sUoM,
    this.numInSale,
    this.stockQty,
    this.price,
    this.priceCurrencyCode,
    this.price1,
    this.price1CurrencyCode,
    this.price11,
    this.price1CurrencyCode1,
    this.price12,
    this.price1CurrencyCode2,
    this.productPrice,
    this.discountItem,
    this.documents,
    this.quantity = 1,  
    this.isFavorite = false,
    this.isLoading = false,
  });
   Map<String, dynamic> get parsedDescription {
    if (description != null) {
      return jsonDecode(description!);
    }
    return {};
  }
  ProductModel.fromJson(Map<String, dynamic> json)
    : quantity = json['quantity'] ?? 1 {
    id = json['id'];
    productName = json['productName'];
    productNameEn = json['productNameEn'];
    barcode = json['barcode'];
    modelNo = json['modelNo'];
    partNo = json['partNo'];
    description = json['description'];
    productColor = json['productColor'];
    hexColorCode = json['hexColorCode'];
    productSize = json['productSize'];
    categoryId = json['categoryId'];
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    brandId = json['brandId'];
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    matrixId = json['matrixId'] != null ? (json['matrixId'] as num).toDouble() : null;
    sUoMEntry = json['sUoMEntry'] != null ? (json['sUoMEntry'] as num).toDouble() : null;
    sUoM = json['sUoM'] != null ? SUoMModel.fromJson(json['sUoM']) : null;
    numInSale = json['numInSale'] != null ? (json['numInSale'] as num).toDouble() : null;
    stockQty = json['stockQty'] != null ? (json['stockQty'] as num).toDouble() : null;
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    priceCurrencyCode = json['priceCurrencyCode'];
    price1 = json['price1'] != null ? (json['price1'] as num).toDouble() : null;
    price1CurrencyCode = json['price1CurrencyCode'];
    price11 = json['price11'] != null ? (json['price11'] as num).toDouble() : null;
    price1CurrencyCode1 = json['price1CurrencyCode1'];
    price12 = json['price12'] != null ? (json['price12'] as num).toDouble() : null;
    price1CurrencyCode2 = json['price1CurrencyCode2'];
    productPrice = json['productPrice'] != null ? ProductPriceModel.fromJson(json['productPrice']) : null;
    discountItem = json['discountItem'] != null ? DiscountIIemModel.fromJson(json['discountItem']) : null;
    if (json['documents'] != null) {
      documents = <DocumentModel>[];
      json['documents'].forEach((v) {
        documents!.add(DocumentModel.fromJson(v));
      });
    }
    isFavorite = json['isFavorite'] ?? false; 
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productNameEn': productNameEn,
      'barcode': barcode,
      'modelNo': modelNo,
      'partNo': partNo,
      'description': description,
      'productColor': productColor,
      'hexColorCode': hexColorCode,
      'productSize': productSize,
      'categoryId': categoryId,
      'category': category?.toJson(),
      'brandId': brandId,
      'brand': brand?.toJson(),
      'matrixId': matrixId,
      'sUoMEntry': sUoMEntry,
      'sUoM': sUoM?.toJson(),
      'numInSale': numInSale,
      'stockQty': stockQty,
      'price': price,
      'priceCurrencyCode': priceCurrencyCode,
      'price1': price1,
      'price1CurrencyCode': price1CurrencyCode,
      'price11': price11,
      'price1CurrencyCode1': price1CurrencyCode1,
      'price12': price12,
      'price1CurrencyCode2': price1CurrencyCode2,
      'productPrice': productPrice?.toJson(),
      'discountItem': discountItem?.toJson(),
      'documents': documents?.map((v) => v.toJson()).toList(),
      'quantity': quantity,
      'isFavorite': isFavorite, 
      'isLoading': isLoading, 
    };
  }
}
