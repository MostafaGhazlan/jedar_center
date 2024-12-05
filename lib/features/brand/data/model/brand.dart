import 'package:hive/hive.dart';
import '../../../sliderBanner/data/model/document_model.dart';

 part 'brand.g.dart';
@HiveType(typeId: 10)
class BrandModel {
  @HiveField(0)
  String? id;
  
  @HiveField(1)
  String? brandName;
  
  @HiveField(2)
  String? colorName;
  
  @HiveField(3)
  String? colorCode;
  
  @HiveField(4)
  String? description;
  
  @HiveField(5)
  List<DocumentModel>? document;

  BrandModel(
      {this.id,
      this.brandName,
      this.colorName,
      this.colorCode,
      this.description,
      this.document});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    description = json['description'];

    if (json['documents'] != null) {
      document = List<DocumentModel>.from(
          json['documents'].map((item) => DocumentModel.fromJson(item)));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandName': brandName,
      'colorName': colorName,
      'colorCode': colorCode,
      'description': description,
      'documents': document?.map((item) => item.toJson()).toList(),
    };
  }
}
