import 'dart:convert';
// To parse this JSON data, do
//
//     final getAllProduct = getAllProductFromJson(jsonString);

List<GetAllProduct> getAllProductFromJson(String str) =>
    List<GetAllProduct>.from(
        json.decode(str).map((x) => GetAllProduct.fromJson(x)));

String getAllProductToJson(List<GetAllProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllProduct {
  int pid;
  String proName;
  String proDetail;
  String proImg;
  String proStatus;
  int uidFkSend;
  int uidFkAccept;
  dynamic ridFk;

  GetAllProduct({
    required this.pid,
    required this.proName,
    required this.proDetail,
    required this.proImg,
    required this.proStatus,
    required this.uidFkSend,
    required this.uidFkAccept,
    required this.ridFk,
  });

  factory GetAllProduct.fromJson(Map<String, dynamic> json) => GetAllProduct(
        pid: json["pid"],
        proName: json["pro_name"],
        proDetail: json["pro_detail"],
        proImg: json["pro_img"],
        proStatus: json["pro_status"],
        uidFkSend: json["uid_fk_send"],
        uidFkAccept: json["uid_fk_accept"],
        ridFk: json["rid_fk"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "pro_name": proName,
        "pro_detail": proDetail,
        "pro_img": proImg,
        "pro_status": proStatus,
        "uid_fk_send": uidFkSend,
        "uid_fk_accept": uidFkAccept,
        "rid_fk": ridFk,
      };
}
