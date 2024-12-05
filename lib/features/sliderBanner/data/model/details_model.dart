import 'document_model.dart';

class DetailsModel  {
  String? id;
  String? slideName;
  int? sliderType;
  int? discountFrom;
  int? discountTo;
  int? categoryId;
  String? brandId;
  int? matrixId;
  DocumentModel? document;

  DetailsModel(
      {this.id,
      this.slideName,
      this.sliderType,
      this.discountFrom,
      this.discountTo,
      this.categoryId,
      this.brandId,
      this.matrixId,
      this.document});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slideName = json['slideName'];
    sliderType = json['sliderType'];
    discountFrom = json['discountFrom'];
    discountTo = json['discountTo'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    matrixId = json['matrixId'];
    document = json['document'] != null
        ? DocumentModel.fromJson(json['document'])
        : null;
  }
}
