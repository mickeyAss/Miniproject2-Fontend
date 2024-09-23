import 'dart:convert';
// To parse this JSON data, do
//
//     final registerRiderRespone = registerRiderResponeFromJson(jsonString);

RegisterRiderRespone registerRiderResponeFromJson(String str) =>
    RegisterRiderRespone.fromJson(json.decode(str));

String registerRiderResponeToJson(RegisterRiderRespone data) =>
    json.encode(data.toJson());

class RegisterRiderRespone {
  String message;
  User user;

  RegisterRiderRespone({
    required this.message,
    required this.user,
  });

  factory RegisterRiderRespone.fromJson(Map<String, dynamic> json) =>
      RegisterRiderRespone(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  int rid;
  String name;
  String lastname;
  String phone;
  String password;
  String img;
  String carRegistration;

  User({
    required this.rid,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.password,
    required this.img,
    required this.carRegistration,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        rid: json["rid"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        img: json["img"],
        carRegistration: json["car_registration"],
      );

  Map<String, dynamic> toJson() => {
        "rid": rid,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "img": img,
        "car_registration": carRegistration,
      };
}
