import 'package:hive/hive.dart';
import '../../../sliderBanner/data/model/document_model.dart';

part 'category.g.dart'; 

@HiveType(typeId: 8)
class CategoryModel {
  @HiveField(0)
  String? id;
  
  @HiveField(1)
  String? categoryCode;
  
  @HiveField(2)
  String? categoryName;
  
  @HiveField(3)
  String? parentId;
  
  @HiveField(4)
  String? description;
  
  @HiveField(5)
  List<Children>? children;
  
  @HiveField(6)
  String? concurrencyStamp;
  
  @HiveField(7)
  List<DocumentModel>? documents;

  CategoryModel(
      {this.id,
      this.categoryCode,
      this.categoryName,
      this.parentId,
      this.description,
      this.documents,
      this.children,
      this.concurrencyStamp});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryCode = json['categoryCode'];
    categoryName = json['categoryName'];
    parentId = json['parentId'];
    description = json['description'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <DocumentModel>[];
      json['documents'].forEach((v) {
        documents!.add(DocumentModel.fromJson(v));
      });
    }
    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryCode'] = categoryCode;
    data['categoryName'] = categoryName;
    data['parentId'] = parentId;
    data['description'] = description;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['concurrencyStamp'] = concurrencyStamp;
    return data;
  }
}



@HiveType(typeId: 9)
class Children {
  @HiveField(0)
  String? id;
  
  @HiveField(1)
  String? categoryCode;
  
  @HiveField(2)
  String? categoryName;
  
  @HiveField(3)
  String? parentId;
  
  @HiveField(4)
  String? description;
  
  @HiveField(5)
  List<Children>? children;
  
  @HiveField(6)
  String? concurrencyStamp;
  
  @HiveField(7)
  List<DocumentModel>? documents;

  Children(
      {this.id,
      this.categoryCode,
      this.categoryName,
      this.parentId,
      this.description,
      this.children,
      this.documents,
      this.concurrencyStamp});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryCode = json['categoryCode'];
    categoryName = json['categoryName'];
    parentId = json['parentId'];
    description = json['description'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <DocumentModel>[];
      json['documents'].forEach((v) {
        documents!.add(DocumentModel.fromJson(v));
      });
    }
    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryCode'] = categoryCode;
    data['categoryName'] = categoryName;
    data['parentId'] = parentId;
    data['description'] = description;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['concurrencyStamp'] = concurrencyStamp;
    return data;
  }
}

