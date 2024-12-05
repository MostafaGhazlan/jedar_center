import 'package:hive_flutter/hive_flutter.dart';

part 'document_model.g.dart';

@HiveType(typeId: 2)
class DocumentModel {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? filePath;
  @HiveField(3)
  String? fileName;
  @HiveField(4)
  String? contentType;

  DocumentModel({this.id, this.filePath, this.fileName, this.contentType});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filePath = json['filePath'];
    fileName = json['fileName'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filePath': filePath,
      'fileName': fileName,
      'contentType': contentType,
    };
  }
}
