import 'dart:convert';
// To parse this JSON data, do
//
//     final loginUserRespone = loginUserResponeFromJson(jsonString);

LoginUserRespone loginUserResponeFromJson(String str) =>
    LoginUserRespone.fromJson(json.decode(str));

String loginUserResponeToJson(LoginUserRespone data) =>
    json.encode(data.toJson());

class LoginUserRespone {
  String message;
  User user;

  LoginUserRespone({
    required this.message,
    required this.user,
  });

  factory LoginUserRespone.fromJson(Map<String, dynamic> json) =>
      LoginUserRespone(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  int uid;
  String name;
  String lastname;
  String phone;
  String password;
  String address;
  String img;

  User({
    required this.uid,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.password,
    required this.address,
    required this.img,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "address": address,
        "img": img,
      };
}
