import 'dart:convert';
// To parse this JSON data, do
//
//     final getProduct = getProductFromJson(jsonString);

GetProduct getProductFromJson(String str) =>
    GetProduct.fromJson(json.decode(str));

String getProductToJson(GetProduct data) => json.encode(data.toJson());

class GetProduct {
  int pid;
  String proName;
  String proDetail;
  String proImg;
  String proStatus;
  String trackingNumber;
  int uidFkSend;
  int uidFkAccept;
  dynamic ridFk;
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

  GetProduct({
    required this.pid,
    required this.proName,
    required this.proDetail,
    required this.proImg,
    required this.proStatus,
    required this.trackingNumber,
    required this.uidFkSend,
    required this.uidFkAccept,
    required this.ridFk,
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

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        pid: json["pid"],
        proName: json["pro_name"],
        proDetail: json["pro_detail"],
        proImg: json["pro_img"],
        proStatus: json["pro_status"],
        trackingNumber: json["tracking_number"],
        uidFkSend: json["uid_fk_send"],
        uidFkAccept: json["uid_fk_accept"],
        ridFk: json["rid_fk"],
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
        "pid": pid,
        "pro_name": proName,
        "pro_detail": proDetail,
        "pro_img": proImg,
        "pro_status": proStatus,
        "tracking_number": trackingNumber,
        "uid_fk_send": uidFkSend,
        "uid_fk_accept": uidFkAccept,
        "rid_fk": ridFk,
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
