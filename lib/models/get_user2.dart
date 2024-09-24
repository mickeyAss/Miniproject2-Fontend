import 'dart:convert';
// To parse this JSON data, do
//
//     final getUser2 = getUser2FromJson(jsonString);

List<GetUser2> getUser2FromJson(String str) =>
    List<GetUser2>.from(json.decode(str).map((x) => GetUser2.fromJson(x)));

String getUser2ToJson(List<GetUser2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUser2 {
  int uid;
  String name;
  String lastname;
  String phone;
  String password;
  String address;
  String latitude;
  String longitude;
  String img;

  GetUser2({
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

  factory GetUser2.fromJson(Map<String, dynamic> json) => GetUser2(
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
