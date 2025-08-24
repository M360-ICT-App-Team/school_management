import 'dart:convert';

TeacherLoginRequestModel teacherLoginRequestModelFromJson(String str) => TeacherLoginRequestModel.fromJson(json.decode(str));

String teacherLoginRequestModelToJson(TeacherLoginRequestModel data) => json.encode(data.toJson());

class TeacherLoginRequestModel {
    final String? loginId;
    final String? password;

    TeacherLoginRequestModel({
        this.loginId,
        this.password,
    });

    factory TeacherLoginRequestModel.fromJson(Map<String, dynamic> json) => TeacherLoginRequestModel(
        loginId: json["login_id"],
        password: json["password"],
    );


    Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "password": password,
    };
}
