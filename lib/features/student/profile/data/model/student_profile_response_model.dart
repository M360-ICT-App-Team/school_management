
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
    final String? status;
    final int? instituteId;
    final int? departmentId;
    final String? departmentName;
    final DateTime? dobDate;
    final String? dobNo;
    final dynamic religion;
    final String? gender;
    final String? bloodGroup;
    final String? permanentAddress;
    final String? presentAddress;
    final String? fatherName;
    final String? motherName;
    final String? emergencyPhoneNo;
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
        this.presentAddress,
        this.fatherName,
        this.motherName,
        this.emergencyPhoneNo,
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
        status: json["status"],
        instituteId: json["institute_id"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        dobDate: json["dob_date"] == null ? null : DateTime.parse(json["dob_date"]),
        dobNo: json["dob_no"],
        religion: json["religion"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        permanentAddress: json["permanent_address"],
        presentAddress: json["present_address"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
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
        "dob_date": dobDate?.toIso8601String(),
        "dob_no": dobNo,
        "religion": religion,
        "gender": gender,
        "blood_group": bloodGroup,
        "permanent_address": permanentAddress,
        "present_address": presentAddress,
        "father_name": fatherName,
        "mother_name": motherName,
        "emergency_phone_no": emergencyPhoneNo,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "created_by_name": createdByName,
    };
}