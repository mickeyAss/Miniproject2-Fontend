import 'dart:convert';
// To parse this JSON data, do
//
//     final searchUserRespone = searchUserResponeFromJson(jsonString);

List<SearchUserRespone> searchUserResponeFromJson(String str) =>
    List<SearchUserRespone>.from(
        json.decode(str).map((x) => SearchUserRespone.fromJson(x)));

String searchUserResponeToJson(List<SearchUserRespone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchUserRespone {
  int uid;
  String name;
  String lastname;
  String phone;
  String password;
  String address;
  String latitude;
  String longitude;
  String img;

  SearchUserRespone({
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

  factory SearchUserRespone.fromJson(Map<String, dynamic> json) =>
      SearchUserRespone(
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
