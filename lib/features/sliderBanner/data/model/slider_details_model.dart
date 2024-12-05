import 'document_model.dart';

class SliderDetailsModel {
  String? id;
  String? slideName;
  String? url;
  int? sliderType;
  int? discountFrom;
  int? discountTo;
  int? categoryId;
  String? brandId;
  int? matrixId;
  DocumentModel? document;

  SliderDetailsModel(
      {this.id,
      this.slideName,
      this.sliderType,
      this.url,
      this.discountFrom,
      this.discountTo,
      this.categoryId,
      this.brandId,
      this.matrixId,
      this.document});

  SliderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['slideName'] = slideName;
    data['sliderType'] = sliderType;
    data['discountFrom'] = discountFrom;
    data['discountTo'] = discountTo;
    data['categoryId'] = categoryId;
    data['brandId'] = brandId;
    data['matrixId'] = matrixId;
    if (document != null) {
      data['document'] = document!.toJson();
    }
    return data;
  }
}

