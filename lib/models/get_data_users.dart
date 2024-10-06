import 'dart:convert';
// To parse this JSON data, do
//
//     final getDataUsers = getDataUsersFromJson(jsonString);

GetDataUsers getDataUsersFromJson(String str) =>
    GetDataUsers.fromJson(json.decode(str));

String getDataUsersToJson(GetDataUsers data) => json.encode(data.toJson());

class GetDataUsers {
  int uid;
  String name;
  String lastname;
  String phone;
  String password;
  String address;
  String latitude;
  String longitude;
  String img;

  GetDataUsers({
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

  factory GetDataUsers.fromJson(Map<String, dynamic> json) => GetDataUsers(
        uid: json["uid"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
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
