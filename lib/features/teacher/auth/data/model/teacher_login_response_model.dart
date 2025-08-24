import 'dart:convert';

TeacherLoginResponseModel teacherLoginResponseModelFromJson(String str) => TeacherLoginResponseModel.fromJson(json.decode(str));

String teacherLoginResponseModelToJson(TeacherLoginResponseModel data) => json.encode(data.toJson());

class TeacherLoginResponseModel {
    final int? userId;
    final String? loginId;
    final String? email;
    final String? name;
    final dynamic photo;
    final String? phone;
    final String? userType;
    final bool? is2FaOn;
    final String? status;
    final int? instituteId;

    TeacherLoginResponseModel({
        this.userId,
        this.loginId,
        this.email,
        this.name,
        this.photo,
        this.phone,
        this.userType,
        this.is2FaOn,
        this.status,
        this.instituteId,
    });

    factory TeacherLoginResponseModel.fromJson(Map<String, dynamic> json) => TeacherLoginResponseModel(
        userId: json["user_id"],
        loginId: json["login_id"],
        email: json["email"],
        name: json["name"],
        photo: json["photo"],
        phone: json["phone"],
        userType: json["user_type"],
        is2FaOn: json["is_2fa_on"],
        status: json["status"],
        instituteId: json["institute_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "login_id": loginId,
        "email": email,
        "name": name,
        "photo": photo,
        "phone": phone,
        "user_type": userType,
        "is_2fa_on": is2FaOn,
        "status": status,
        "institute_id": instituteId,
    };
}