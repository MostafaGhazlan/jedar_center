import 'package:flutter_application_1/features/product/data/model/product.dart';

class OrderModel {
  int? id;
  String? docRef;
  int? docStatus;
  String? docDate;
  String? docStatusName;
  String? phone1;
  String? phone2;
  String? address;
  String? latitude;
  String? longitude;
  double? totalAmount;
  double? totalAmountSc;
  double? netAmount;
  double? netAmountSc;
  int? discountType;
  double? discountTypeAmount;
  double? discountAmount;
  double? discountAmountSc;
  double? totalItemDiscount;
  double? totalItemDiscountSc;
  double? totalDiscount;
  double? totalDiscountSc;
  List<Details>? details;

  OrderModel(
      {this.id,
      this.docRef,
      this.docStatus,
      this.docDate,
      this.phone1,
      this.phone2,
      this.address,
      this.latitude,
      this.longitude,
      this.totalAmount,
      this.totalAmountSc,
      this.netAmount,
      this.netAmountSc,
      this.discountType,
      this.discountTypeAmount,
      this.discountAmount,
      this.discountAmountSc,
      this.totalItemDiscount,
      this.totalItemDiscountSc,
      this.totalDiscount,
      this.totalDiscountSc,
      this.docStatusName,
      this.details});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docStatusName = json['docStatusName'];
    docRef = json['docRef'];
    docStatus = json['docStatus'];
    docDate = json['docDate'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    totalAmount = json['totalAmount'] != null
        ? (json['totalAmount'] is int)
            ? (json['totalAmount'] as int).toDouble()
            : double.tryParse(json['totalAmount'].toString()) ?? 0.0
        : 0.0;

    totalAmountSc = json['totalAmountSc'] != null
        ? (json['totalAmountSc'] is int)
            ? (json['totalAmountSc'] as int).toDouble()
            : double.tryParse(json['totalAmountSc'].toString()) ?? 0.0
        : 0.0;

    netAmount = json['netAmount'] != null
        ? (json['netAmount'] is int)
            ? (json['netAmount'] as int).toDouble()
            : double.tryParse(json['netAmount'].toString()) ?? 0.0
        : 0.0;

    netAmountSc = json['netAmountSc'] != null
        ? (json['netAmountSc'] is int)
            ? (json['netAmountSc'] as int).toDouble()
            : double.tryParse(json['netAmountSc'].toString()) ?? 0.0
        : 0.0;

    discountType = json['discountType'];

    discountTypeAmount = json['discountTypeAmount'] != null
        ? (json['discountTypeAmount'] is int)
            ? (json['discountTypeAmount'] as int).toDouble()
            : double.tryParse(json['discountTypeAmount'].toString()) ?? 0.0
        : 0.0;

    discountAmount = json['discountAmount'] != null
        ? (json['discountAmount'] is int)
            ? (json['discountAmount'] as int).toDouble()
            : double.tryParse(json['discountAmount'].toString()) ?? 0.0
        : 0.0;

    discountAmountSc = json['discountAmountSc'] != null
        ? (json['discountAmountSc'] is int)
            ? (json['discountAmountSc'] as int).toDouble()
            : double.tryParse(json['discountAmountSc'].toString()) ?? 0.0
        : 0.0;

    totalItemDiscount = json['totalItemDiscount'] != null
        ? (json['totalItemDiscount'] is int)
            ? (json['totalItemDiscount'] as int).toDouble()
            : double.tryParse(json['totalItemDiscount'].toString()) ?? 0.0
        : 0.0;

    totalItemDiscountSc = json['totalItemDiscountSc'] != null
        ? (json['totalItemDiscountSc'] is int)
            ? (json['totalItemDiscountSc'] as int).toDouble()
            : double.tryParse(json['totalItemDiscountSc'].toString()) ?? 0.0
        : 0.0;

    totalDiscount = json['totalDiscount'] != null
        ? (json['totalDiscount'] is int)
            ? (json['totalDiscount'] as int).toDouble()
            : double.tryParse(json['totalDiscount'].toString()) ?? 0.0
        : 0.0;

    totalDiscountSc = json['totalDiscountSc'] != null
        ? (json['totalDiscountSc'] is int)
            ? (json['totalDiscountSc'] as int).toDouble()
            : double.tryParse(json['totalDiscountSc'].toString()) ?? 0.0
        : 0.0;

    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['docRef'] = docRef;
    data['docStatus'] = docStatus;
    data['docStatusName'] = docStatusName;
    data['docDate'] = docDate;
    data['phone1'] = phone1;
    data['phone2'] = phone2;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['totalAmount'] = totalAmount;
    data['totalAmountSc'] = totalAmountSc;
    data['netAmount'] = netAmount;
    data['netAmountSc'] = netAmountSc;
    data['discountType'] = discountType;
    data['discountTypeAmount'] = discountTypeAmount;
    data['discountAmount'] = discountAmount;
    data['discountAmountSc'] = discountAmountSc;
    data['totalItemDiscount'] = totalItemDiscount;
    data['totalItemDiscountSc'] = totalItemDiscountSc;
    data['totalDiscount'] = totalDiscount;
    data['totalDiscountSc'] = totalDiscountSc;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? docId;
  String? productId;
  ProductModel? product;
  int? unitId;
  double? qty;
  double? pQty;
  double? numPerMsr;
  double? price;
  double? priceBefDis;
  double? lineTotalAmount;
  double? lineTotalAmountSc;
  double? lineNetAmount;
  double? lineNetAmountSc;
  int? discountType;
  double? discountTypeAmount;
  double? discountAmount;
  double? discountAmountSc;
  double? lineDiscountAmount;
  double? lineDiscountAmountSc;
  String? concurrencyStamp;

  Details(
      {this.id,
      this.docId,
      this.productId,
      this.product,
      this.unitId,
      this.qty,
      this.pQty,
      this.numPerMsr,
      this.price,
      this.priceBefDis,
      this.lineTotalAmount,
      this.lineTotalAmountSc,
      this.lineNetAmount,
      this.lineNetAmountSc,
      this.discountType,
      this.discountTypeAmount,
      this.discountAmount,
      this.discountAmountSc,
      this.lineDiscountAmount,
      this.lineDiscountAmountSc,
      this.concurrencyStamp});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docId = json['docId'];
    productId = json['productId'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    unitId = json['unitId'];
    qty = json['qty'] != null
        ? (json['qty'] is int)
            ? (json['qty'] as int).toDouble()
            : double.tryParse(json['qty'].toString()) ?? 0.0
        : 0.0;

    pQty = json['pQty'] != null
        ? (json['pQty'] is int)
            ? (json['pQty'] as int).toDouble()
            : double.tryParse(json['pQty'].toString()) ?? 0.0
        : 0.0;

    numPerMsr = json['numPerMsr'] != null
        ? (json['numPerMsr'] is int)
            ? (json['numPerMsr'] as int).toDouble()
            : double.tryParse(json['numPerMsr'].toString()) ?? 0.0
        : 0.0;
    price = json['price'] != null
        ? (json['price'] is int)
            ? (json['price'] as int).toDouble()
            : double.tryParse(json['price'].toString()) ?? 0.0
        : 0.0;

    priceBefDis = json['priceBefDis'] != null
        ? (json['priceBefDis'] is int)
            ? (json['priceBefDis'] as int).toDouble()
            : double.tryParse(json['priceBefDis'].toString()) ?? 0.0
        : 0.0;

    lineTotalAmount = json['lineTotalAmount'] != null
        ? (json['lineTotalAmount'] is int)
            ? (json['lineTotalAmount'] as int).toDouble()
            : double.tryParse(json['lineTotalAmount'].toString()) ?? 0.0
        : 0.0;

    lineTotalAmountSc = json['lineTotalAmountSc'] != null
        ? (json['lineTotalAmountSc'] is int)
            ? (json['lineTotalAmountSc'] as int).toDouble()
            : double.tryParse(json['lineTotalAmountSc'].toString()) ?? 0.0
        : 0.0;

    lineNetAmount = json['lineNetAmount'] != null
        ? (json['lineNetAmount'] is int)
            ? (json['lineNetAmount'] as int).toDouble()
            : double.tryParse(json['lineNetAmount'].toString()) ?? 0.0
        : 0.0;

    lineNetAmountSc = json['lineNetAmountSc'] != null
        ? (json['lineNetAmountSc'] is int)
            ? (json['lineNetAmountSc'] as int).toDouble()
            : double.tryParse(json['lineNetAmountSc'].toString()) ?? 0.0
        : 0.0;

    discountType = json['discountType'];

    discountTypeAmount = json['discountTypeAmount'] != null
        ? (json['discountTypeAmount'] is int)
            ? (json['discountTypeAmount'] as int).toDouble()
            : double.tryParse(json['discountTypeAmount'].toString()) ?? 0.0
        : 0.0;

    discountAmount = json['discountAmount'] != null
        ? (json['discountAmount'] is int)
            ? (json['discountAmount'] as int).toDouble()
            : double.tryParse(json['discountAmount'].toString()) ?? 0.0
        : 0.0;

    discountAmountSc = json['discountAmountSc'] != null
        ? (json['discountAmountSc'] is int)
            ? (json['discountAmountSc'] as int).toDouble()
            : double.tryParse(json['discountAmountSc'].toString()) ?? 0.0
        : 0.0;

    lineDiscountAmount = json['lineDiscountAmount'] != null
        ? (json['lineDiscountAmount'] is int)
            ? (json['lineDiscountAmount'] as int).toDouble()
            : double.tryParse(json['lineDiscountAmount'].toString()) ?? 0.0
        : 0.0;

    lineDiscountAmountSc = json['lineDiscountAmountSc'] != null
        ? (json['lineDiscountAmountSc'] is int)
            ? (json['lineDiscountAmountSc'] as int).toDouble()
            : double.tryParse(json['lineDiscountAmountSc'].toString()) ?? 0.0
        : 0.0;

    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['docId'] = docId;
    data['productId'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['unitId'] = unitId;
    data['qty'] = qty;
    data['pQty'] = pQty;
    data['numPerMsr'] = numPerMsr;
    data['price'] = price;
    data['priceBefDis'] = priceBefDis;
    data['lineTotalAmount'] = lineTotalAmount;
    data['lineTotalAmountSc'] = lineTotalAmountSc;
    data['lineNetAmount'] = lineNetAmount;
    data['lineNetAmountSc'] = lineNetAmountSc;
    data['discountType'] = discountType;
    data['discountTypeAmount'] = discountTypeAmount;
    data['discountAmount'] = discountAmount;
    data['discountAmountSc'] = discountAmountSc;
    data['lineDiscountAmount'] = lineDiscountAmount;
    data['lineDiscountAmountSc'] = lineDiscountAmountSc;
    data['concurrencyStamp'] = concurrencyStamp;
    return data;
  }
}
