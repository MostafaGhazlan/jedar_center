import 'package:hive/hive.dart';

part 'suom_model.g.dart';

@HiveType(typeId: 7) 
class SUoMModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? unitSymbole;

  @HiveField(2)
  String? unitName;

  @HiveField(3)
  String? description;

  SUoMModel({this.id, this.unitSymbole, this.unitName, this.description});

  factory SUoMModel.fromJson(Map<String, dynamic> json) {
    return SUoMModel(
      id: json['id'],
      unitSymbole: json['unitSymbole'],
      unitName: json['unitName'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unitSymbole': unitSymbole,
      'unitName': unitName,
      'description': description,
    };
  }
}
