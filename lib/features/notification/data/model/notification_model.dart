class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? userId;
  String? concurrencyStamp;

  NotificationModel(
      {this.id, this.title, this.body, this.userId, this.concurrencyStamp});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['userId'] = userId;
    data['concurrencyStamp'] = concurrencyStamp;
    return data;
  }
}