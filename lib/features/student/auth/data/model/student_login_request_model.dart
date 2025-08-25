import 'dart:convert';

StudentLoginRequestModel studentLoginRequestModelFromJson(String str) => StudentLoginRequestModel.fromJson(json.decode(str));

String studentLoginRequestModelToJson(StudentLoginRequestModel data) => json.encode(data.toJson());

class StudentLoginRequestModel {
    final String? loginId;
    final String? password;

    StudentLoginRequestModel({
        this.loginId,
        this.password,
    });

    factory StudentLoginRequestModel.fromJson(Map<String, dynamic> json) => StudentLoginRequestModel(
        loginId: json["login_id"],
        password: json["password"],
    );


    Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "password": password,
    };
}
