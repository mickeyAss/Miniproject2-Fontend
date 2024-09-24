import 'dart:convert';
// To parse this JSON data, do
//
//     final getDataRider = getDataRiderFromJson(jsonString);


GetDataRider getDataRiderFromJson(String str) => GetDataRider.fromJson(json.decode(str));

String getDataRiderToJson(GetDataRider data) => json.encode(data.toJson());

class GetDataRider {
    int rid;
    String name;
    String lastname;
    String phone;
    String password;
    String img;
    String carRegistration;

    GetDataRider({
        required this.rid,
        required this.name,
        required this.lastname,
        required this.phone,
        required this.password,
        required this.img,
        required this.carRegistration,
    });

    factory GetDataRider.fromJson(Map<String, dynamic> json) => GetDataRider(
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
