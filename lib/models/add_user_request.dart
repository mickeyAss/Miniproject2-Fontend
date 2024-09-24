import 'dart:convert';
// To parse this JSON data, do
//
//     final addUserRequest = addUserRequestFromJson(jsonString);


AddUserRequest addUserRequestFromJson(String str) => AddUserRequest.fromJson(json.decode(str));

String addUserRequestToJson(AddUserRequest data) => json.encode(data.toJson());

class AddUserRequest {
    String proName;
    String proDetail;
    String proImg;
    String uidFkSend;
    String uidFkAccept;

    AddUserRequest({
        required this.proName,
        required this.proDetail,
        required this.proImg,
        required this.uidFkSend,
        required this.uidFkAccept,
    });

    factory AddUserRequest.fromJson(Map<String, dynamic> json) => AddUserRequest(
        proName: json["pro_name"],
        proDetail: json["pro_detail"],
        proImg: json["pro_img"],
        uidFkSend: json["uid_fk_send"],
        uidFkAccept: json["uid_fk_accept"],
    );

    Map<String, dynamic> toJson() => {
        "pro_name": proName,
        "pro_detail": proDetail,
        "pro_img": proImg,
        "uid_fk_send": uidFkSend,
        "uid_fk_accept": uidFkAccept,
    };
}
