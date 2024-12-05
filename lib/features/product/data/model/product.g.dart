// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String?,
      productName: fields[1] as String?,
      productNameEn: fields[2] as String?,
      barcode: fields[3] as String?,
      modelNo: fields[4] as String?,
      partNo: fields[5] as String?,
      description: fields[6] as String?,
      productColor: fields[7] as String?,
      hexColorCode: fields[8] as String?,
      productSize: fields[9] as String?,
      categoryId: fields[10] as String?,
      category: fields[11] as CategoryModel?,
      brandId: fields[12] as String?,
      brand: fields[13] as BrandModel?,
      matrixId: fields[14] as double?,
      sUoMEntry: fields[15] as double?,
      sUoM: fields[16] as SUoMModel?,
      numInSale: fields[17] as double?,
      stockQty: fields[18] as double?,
      price: fields[19] as double?,
      priceCurrencyCode: fields[20] as String?,
      price1: fields[21] as double?,
      price1CurrencyCode: fields[22] as String?,
      price11: fields[23] as double?,
      price1CurrencyCode1: fields[24] as String?,
      price12: fields[25] as double?,
      price1CurrencyCode2: fields[26] as String?,
      productPrice: fields[27] as ProductPriceModel?,
      discountItem: fields[28] as DiscountIIemModel?,
      documents: (fields[29] as List?)?.cast<DocumentModel>(),
      quantity: fields[30] as int,
      isFavorite: fields[31] as bool,
      isLoading: fields[32] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.productNameEn)
      ..writeByte(3)
      ..write(obj.barcode)
      ..writeByte(4)
      ..write(obj.modelNo)
      ..writeByte(5)
      ..write(obj.partNo)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.productColor)
      ..writeByte(8)
      ..write(obj.hexColorCode)
      ..writeByte(9)
      ..write(obj.productSize)
      ..writeByte(10)
      ..write(obj.categoryId)
      ..writeByte(11)
      ..write(obj.category)
      ..writeByte(12)
      ..write(obj.brandId)
      ..writeByte(13)
      ..write(obj.brand)
      ..writeByte(14)
      ..write(obj.matrixId)
      ..writeByte(15)
      ..write(obj.sUoMEntry)
      ..writeByte(16)
      ..write(obj.sUoM)
      ..writeByte(17)
      ..write(obj.numInSale)
      ..writeByte(18)
      ..write(obj.stockQty)
      ..writeByte(19)
      ..write(obj.price)
      ..writeByte(20)
      ..write(obj.priceCurrencyCode)
      ..writeByte(21)
      ..write(obj.price1)
      ..writeByte(22)
      ..write(obj.price1CurrencyCode)
      ..writeByte(23)
      ..write(obj.price11)
      ..writeByte(24)
      ..write(obj.price1CurrencyCode1)
      ..writeByte(25)
      ..write(obj.price12)
      ..writeByte(26)
      ..write(obj.price1CurrencyCode2)
      ..writeByte(27)
      ..write(obj.productPrice)
      ..writeByte(28)
      ..write(obj.discountItem)
      ..writeByte(29)
      ..write(obj.documents)
      ..writeByte(30)
      ..write(obj.quantity)
      ..writeByte(31)
      ..write(obj.isFavorite)
      ..writeByte(32)
      ..write(obj.isLoading);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
