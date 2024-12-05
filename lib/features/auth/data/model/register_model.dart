
class RegisterModel  {
  String? username;
  String? password;
  String? email;
  String? name;
  String? surname;
  String? phoneNumber;
  String? mobile;
  String? address;
  String? secondAddress;
  String? latitude;
  String? longitude;

  RegisterModel({
    required this.username,
    required this.password,
    required this.address,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.mobile,
    required this.name,
    required this.phoneNumber,
    required this.secondAddress,
    required this.surname,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    address = json['address'];
    email = json['email'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mobile = json['mobile'];
    phoneNumber = json['phoneNumber'];
    secondAddress = json['secondAddress'];
    surname = json['surname'];
  }
}
