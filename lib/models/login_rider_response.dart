import 'dart:convert';
// To parse this JSON data, do
//
//     final loginRiderRespone = loginRiderResponeFromJson(jsonString);


LoginRiderRespone loginRiderResponeFromJson(String str) => LoginRiderRespone.fromJson(json.decode(str));

String loginRiderResponeToJson(LoginRiderRespone data) => json.encode(data.toJson());

class LoginRiderRespone {
    String message;
    Rider rider;

    LoginRiderRespone({
        required this.message,
        required this.rider,
    });

    factory LoginRiderRespone.fromJson(Map<String, dynamic> json) => LoginRiderRespone(
        message: json["message"],
        rider: Rider.fromJson(json["rider"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "rider": rider.toJson(),
    };
}

class Rider {
    int rid;
    String name;
    String lastname;
    String phone;
    String password;
    String img;
    String carRegistration;

    Rider({
        required this.rid,
        required this.name,
        required this.lastname,
        required this.phone,
        required this.password,
        required this.img,
        required this.carRegistration,
    });

    factory Rider.fromJson(Map<String, dynamic> json) => Rider(
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
