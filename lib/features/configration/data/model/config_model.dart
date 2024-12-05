import 'package:hive/hive.dart';

part 'config_model.g.dart';
@HiveType(typeId: 5)
class CurrentUserModel {
  @HiveField(0)
  String? id;
  
  @HiveField(1)
  String? tenantId;
  
  @HiveField(2) 
  String? name;
  
  @HiveField(3) 
  String? surname;
  
  @HiveField(4)
  String? userName;
  
  @HiveField(5) 
  String? email;
  
  @HiveField(6) 
  String? phoneNumber;
  
  @HiveField(7) 
  String? mobile;
  
  @HiveField(8) 
  String? address;
  
  @HiveField(9) 
  String? secondAddress;
  
  @HiveField(10) 
  String? latitude;
  
  @HiveField(11) 
  String? longitude;
  
  @HiveField(12)
  bool? isAuthenticated;
  
  @HiveField(13) 
  String? concurrencyStamp;

  CurrentUserModel(
      {this.id,
      this.tenantId,
      this.name,
      this.surname,
      this.userName,
      this.email,
      this.phoneNumber,
      this.mobile,
      this.address,
      this.secondAddress,
      this.latitude,
      this.longitude,
      this.isAuthenticated,
      this.concurrencyStamp});

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      id: json['id'],
      tenantId: json['tenantId'],
      name: json['name'],
      surname: json['surname'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      mobile: json['mobile'],
      address: json['address'],
      secondAddress: json['secondAddress'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isAuthenticated: json['isAuthenticated'],
      concurrencyStamp: json['concurrencyStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenantId': tenantId,
      'name': name,
      'surname': surname,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'mobile': mobile,
      'address': address,
      'secondAddress': secondAddress,
      'latitude': latitude,
      'longitude': longitude,
      'isAuthenticated': isAuthenticated,
      'concurrencyStamp': concurrencyStamp,
    };
  }
}
