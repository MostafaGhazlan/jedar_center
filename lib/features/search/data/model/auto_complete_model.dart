class AutoCompleteModel {
  String? id;
  String? name;
  String? type;

  AutoCompleteModel({this.id, this.name, this.type});

  AutoCompleteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}