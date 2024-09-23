import 'dart:convert';
// To parse this JSON data, do
//
//     final loginUserRequest = loginUserRequestFromJson(jsonString);


LoginUserRequest loginUserRequestFromJson(String str) => LoginUserRequest.fromJson(json.decode(str));

String loginUserRequestToJson(LoginUserRequest data) => json.encode(data.toJson());

class LoginUserRequest {
    String phone;
    String password;

    LoginUserRequest({
        required this.phone,
        required this.password,
    });

    factory LoginUserRequest.fromJson(Map<String, dynamic> json) => LoginUserRequest(
        phone: json["phone"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
    };
}
