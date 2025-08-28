// To parse this JSON data, do
//
//     final studentProfileResponseModel = studentProfileResponseModelFromJson(jsonString);

import 'dart:convert';

StudentProfileResponseModel studentProfileResponseModelFromJson(String str) => StudentProfileResponseModel.fromJson(json.decode(str));

String studentProfileResponseModelToJson(StudentProfileResponseModel data) => json.encode(data.toJson());

class StudentProfileResponseModel {
    final int? id;
    final String? name;
    final String? email;
    final String? phone;
    final dynamic photo;
    final String? loginId;
    final int? instituteId;
    final String? status;
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
    final dynamic fatherName;
    final dynamic fatherNidNo;
    final dynamic fatherPhone;
    final dynamic motherName;
    final dynamic motherNidNo;
    final dynamic motherPhone;
    final dynamic localGuardianRelation;
    final dynamic localGuardianName;
    final dynamic localGuardianNidNo;
    final dynamic localGuardianPhone;
    final dynamic emergencyPhoneNo;
    final int? departmentId;
    final String? departmentName;
    final DateTime? createdAt;
    final int? createdBy;
    final String? createdByName;

    StudentProfileResponseModel({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.loginId,
        this.instituteId,
        this.status,
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
        this.fatherName,
        this.fatherNidNo,
        this.fatherPhone,
        this.motherName,
        this.motherNidNo,
        this.motherPhone,
        this.localGuardianRelation,
        this.localGuardianName,
        this.localGuardianNidNo,
        this.localGuardianPhone,
        this.emergencyPhoneNo,
        this.departmentId,
        this.departmentName,
        this.createdAt,
        this.createdBy,
        this.createdByName,
    });

    factory StudentProfileResponseModel.fromJson(Map<String, dynamic> json) => StudentProfileResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        photo: json["photo"],
        loginId: json["login_id"],
        instituteId: json["institute_id"],
        status: json["status"],
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
        fatherName: json["father_name"],
        fatherNidNo: json["father_nid_no"],
        fatherPhone: json["father_phone"],
        motherName: json["mother_name"],
        motherNidNo: json["mother_nid_no"],
        motherPhone: json["mother_phone"],
        localGuardianRelation: json["local_guardian_relation"],
        localGuardianName: json["local_guardian_name"],
        localGuardianNidNo: json["local_guardian_nid_no"],
        localGuardianPhone: json["local_guardian_phone"],
        emergencyPhoneNo: json["emergency_phone_no"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
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
        "institute_id": instituteId,
        "status": status,
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
        "father_name": fatherName,
        "father_nid_no": fatherNidNo,
        "father_phone": fatherPhone,
        "mother_name": motherName,
        "mother_nid_no": motherNidNo,
        "mother_phone": motherPhone,
        "local_guardian_relation": localGuardianRelation,
        "local_guardian_name": localGuardianName,
        "local_guardian_nid_no": localGuardianNidNo,
        "local_guardian_phone": localGuardianPhone,
        "emergency_phone_no": emergencyPhoneNo,
        "department_id": departmentId,
        "department_name": departmentName,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "created_by_name": createdByName,
    };
}
