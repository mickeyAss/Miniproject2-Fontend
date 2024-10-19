import 'dart:convert';
// To parse this JSON data, do
//
//     final getStatus = getStatusFromJson(jsonString);


List<GetStatus> getStatusFromJson(String str) => List<GetStatus>.from(json.decode(str).map((x) => GetStatus.fromJson(x)));

String getStatusToJson(List<GetStatus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStatus {
    int sid;
    String staname;
    int uidSend;
    int uidAccept;

    GetStatus({
        required this.sid,
        required this.staname,
        required this.uidSend,
        required this.uidAccept,
    });

    factory GetStatus.fromJson(Map<String, dynamic> json) => GetStatus(
        sid: json["sid"],
        staname: json["staname"],
        uidSend: json["uid_send"],
        uidAccept: json["uid_accept"],
    );

    Map<String, dynamic> toJson() => {
        "sid": sid,
        "staname": staname,
        "uid_send": uidSend,
        "uid_accept": uidAccept,
    };
}
