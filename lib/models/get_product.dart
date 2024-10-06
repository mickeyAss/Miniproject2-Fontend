import 'dart:convert';
// To parse this JSON data, do
//
//     final getProduct = getProductFromJson(jsonString);


GetProduct getProductFromJson(String str) => GetProduct.fromJson(json.decode(str));

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
    };
}
