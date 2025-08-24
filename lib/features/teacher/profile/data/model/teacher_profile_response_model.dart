
import 'dart:convert';

TeacherProfileResponseModel teacherProfileResponseModelFromJson(String str) => TeacherProfileResponseModel.fromJson(json.decode(str));

String teacherProfileResponseModelToJson(TeacherProfileResponseModel data) => json.encode(data.toJson());

class TeacherProfileResponseModel {
    final int? id;
    final String? name;
    final String? email;
    final String? phone;
    final dynamic photo;
    final String? loginId;
    final String? status;
    final int? instituteId;
    final int? departmentId;
    final String? departmentName;
    final dynamic dobDate;
    final dynamic dobNo;
    final dynamic religion;
    final dynamic gender;
    final dynamic bloodGroup;
    final dynamic permanentAddress;
    final dynamic permanentThana;
    final dynamic permanentDivision;
    final dynamic permanentPostalCode;
    final dynamic presentAddress;
    final dynamic presentThana;
    final dynamic presentDivision;
    final dynamic presentPostalCode;
    final dynamic emergencyPhoneNo;
    final DateTime? createdAt;
    final int? createdBy;
    final String? createdByName;

    TeacherProfileResponseModel({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.loginId,
        this.status,
        this.instituteId,
        this.departmentId,
        this.departmentName,
        this.dobDate,
        this.dobNo,
        this.religion,
        this.gender,
        this.bloodGroup,
        this.permanentAddress,
        this.permanentThana,
        this.permanentDivision,
        this.permanentPostalCode,
        this.presentAddress,
        this.presentThana,
        this.presentDivision,
        this.presentPostalCode,
        this.emergencyPhoneNo,
        this.createdAt,
        this.createdBy,
        this.createdByName,
    });

    factory TeacherProfileResponseModel.fromJson(Map<String, dynamic> json) => TeacherProfileResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        photo: json["photo"],
        loginId: json["login_id"],
        status: json["status"],
        instituteId: json["institute_id"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        dobDate: json["dob_date"],
        dobNo: json["dob_no"],
        religion: json["religion"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        permanentAddress: json["permanent_address"],
        permanentThana: json["permanent_thana"],
        permanentDivision: json["permanent_division"],
        permanentPostalCode: json["permanent_postal_code"],
        presentAddress: json["present_address"],
        presentThana: json["present_thana"],
        presentDivision: json["present_division"],
        presentPostalCode: json["present_postal_code"],
        emergencyPhoneNo: json["emergency_phone_no"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "photo": photo,
        "login_id": loginId,
        "status": status,
        "institute_id": instituteId,
        "department_id": departmentId,
        "department_name": departmentName,
        "dob_date": dobDate,
        "dob_no": dobNo,
        "religion": religion,
        "gender": gender,
        "blood_group": bloodGroup,
        "permanent_address": permanentAddress,
        "permanent_thana": permanentThana,
        "permanent_division": permanentDivision,
        "permanent_postal_code": permanentPostalCode,
        "present_address": presentAddress,
        "present_thana": presentThana,
        "present_division": presentDivision,
        "present_postal_code": presentPostalCode,
        "emergency_phone_no": emergencyPhoneNo,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "created_by_name": createdByName,
    };
}