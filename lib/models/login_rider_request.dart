import 'dart:convert';
// To parse this JSON data, do
//
//     final loginRiderRequest = loginRiderRequestFromJson(jsonString);


LoginRiderRequest loginRiderRequestFromJson(String str) => LoginRiderRequest.fromJson(json.decode(str));

String loginRiderRequestToJson(LoginRiderRequest data) => json.encode(data.toJson());

class LoginRiderRequest {
    String phone;
    String password;

    LoginRiderRequest({
        required this.phone,
        required this.password,
    });

    factory LoginRiderRequest.fromJson(Map<String, dynamic> json) => LoginRiderRequest(
        phone: json["phone"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
    };
}
