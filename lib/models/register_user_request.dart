import 'dart:convert';
// To parse this JSON data, do
//
//     final registerUserRequest = registerUserRequestFromJson(jsonString);

RegisterUserRequest registerUserRequestFromJson(String str) =>
    RegisterUserRequest.fromJson(json.decode(str));

String registerUserRequestToJson(RegisterUserRequest data) =>
    json.encode(data.toJson());

class RegisterUserRequest {
  String name;
  String lastname;
  String phone;
  String password;

  RegisterUserRequest({
    required this.name,
    required this.lastname,
    required this.phone,
    required this.password,
  });

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      RegisterUserRequest(
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
      };
}
