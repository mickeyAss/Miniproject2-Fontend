import 'dart:convert';
// To parse this JSON data, do
//
//     final registerRiderRequest = registerRiderRequestFromJson(jsonString);

RegisterRiderRequest registerRiderRequestFromJson(String str) =>
    RegisterRiderRequest.fromJson(json.decode(str));

String registerRiderRequestToJson(RegisterRiderRequest data) =>
    json.encode(data.toJson());

class RegisterRiderRequest {
  String name;
  String lastname;
  String phone;
  String password;
  String img;
  String carRegistration;

  RegisterRiderRequest({
    required this.name,
    required this.lastname,
    required this.phone,
    required this.password,
    required this.img,
    required this.carRegistration,
  });

  factory RegisterRiderRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRiderRequest(
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        img: json["img"],
        carRegistration: json["car_registration"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "img": img,
        "car_registration": carRegistration,
      };
}
