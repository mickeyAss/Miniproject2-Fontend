import 'dart:convert';
// To parse this JSON data, do
//
//     final registerUserResponse = registerUserResponseFromJson(jsonString);


RegisterUserResponse registerUserResponseFromJson(String str) => RegisterUserResponse.fromJson(json.decode(str));

String registerUserResponseToJson(RegisterUserResponse data) => json.encode(data.toJson());

class RegisterUserResponse {
    String message;
    User user;

    RegisterUserResponse({
        required this.message,
        required this.user,
    });

    factory RegisterUserResponse.fromJson(Map<String, dynamic> json) => RegisterUserResponse(
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
    String latitude;
    String longitude;
    String img;

    User({
        required this.uid,
        required this.name,
        required this.lastname,
        required this.phone,
        required this.password,
        required this.address,
        required this.latitude,
        required this.longitude,
        required this.img,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "img": img,
    };
}
