import 'slider_details_model.dart';

class SliderBannerModel {
  int? id;
  String? sliderName;
  int? sliderOrder;
  String? fromDate;
  String? toDate;
  List<SliderDetailsModel>? details;

  SliderBannerModel(
      {this.id,
      this.sliderName,
      this.sliderOrder,
      this.fromDate,
      this.toDate,
      this.details});

  SliderBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderName = json['sliderName'];
    sliderOrder = json['sliderOrder'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    if (json['details'] != null) {
      details = <SliderDetailsModel>[];
      json['details'].forEach((v) {
        details!.add(SliderDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sliderName'] = sliderName;
    data['sliderOrder'] = sliderOrder;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

