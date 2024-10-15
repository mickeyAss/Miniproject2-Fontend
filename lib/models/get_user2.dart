import 'dart:convert';
// To parse this JSON data, do
//
//     final getUser2 = getUser2FromJson(jsonString);

GetUser2 getUser2FromJson(String str) => GetUser2.fromJson(json.decode(str));

String getUser2ToJson(GetUser2 data) => json.encode(data.toJson());

class GetUser2 {
  int senderUid;
  String senderName;
  String senderLastname;
  String senderPhone;
  String senderAddress;
  String senderLatitude;
  String senderLongitude;
  String senderImg;
  int receiverUid;
  String receiverName;
  String receiverLastname;
  String receiverPhone;
  String receiverAddress;
  String receiverLatitude;
  String receiverLongitude;
  String receiverImg;

  GetUser2({
    required this.senderUid,
    required this.senderName,
    required this.senderLastname,
    required this.senderPhone,
    required this.senderAddress,
    required this.senderLatitude,
    required this.senderLongitude,
    required this.senderImg,
    required this.receiverUid,
    required this.receiverName,
    required this.receiverLastname,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.receiverLatitude,
    required this.receiverLongitude,
    required this.receiverImg,
  });

  factory GetUser2.fromJson(Map<String, dynamic> json) => GetUser2(
        senderUid: json["sender_uid"],
        senderName: json["sender_name"],
        senderLastname: json["sender_lastname"],
        senderPhone: json["sender_phone"],
        senderAddress: json["sender_address"],
        senderLatitude: json["sender_latitude"],
        senderLongitude: json["sender_longitude"],
        senderImg: json["sender_img"],
        receiverUid: json["receiver_uid"],
        receiverName: json["receiver_name"],
        receiverLastname: json["receiver_lastname"],
        receiverPhone: json["receiver_phone"],
        receiverAddress: json["receiver_address"],
        receiverLatitude: json["receiver_latitude"],
        receiverLongitude: json["receiver_longitude"],
        receiverImg: json["receiver_img"],
      );

  Map<String, dynamic> toJson() => {
        "sender_uid": senderUid,
        "sender_name": senderName,
        "sender_lastname": senderLastname,
        "sender_phone": senderPhone,
        "sender_address": senderAddress,
        "sender_latitude": senderLatitude,
        "sender_longitude": senderLongitude,
        "sender_img": senderImg,
        "receiver_uid": receiverUid,
        "receiver_name": receiverName,
        "receiver_lastname": receiverLastname,
        "receiver_phone": receiverPhone,
        "receiver_address": receiverAddress,
        "receiver_latitude": receiverLatitude,
        "receiver_longitude": receiverLongitude,
        "receiver_img": receiverImg,
      };
}
