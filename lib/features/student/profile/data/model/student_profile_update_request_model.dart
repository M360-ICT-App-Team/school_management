// To parse this JSON data, do
//
//     final studentProfileUpdateRequestModel = studentProfileUpdateRequestModelFromJson(jsonString);

import 'dart:convert';

StudentProfileUpdateRequestModel studentProfileUpdateRequestModelFromJson(String str) => StudentProfileUpdateRequestModel.fromJson(json.decode(str));

String studentProfileUpdateRequestModelToJson(StudentProfileUpdateRequestModel data) => json.encode(data.toJson());

class StudentProfileUpdateRequestModel {

  final String? name;
  final String? email;
  final String? phone;
  final dynamic is2FaOn;
  final dynamic dobDate;
  final String? dobNo;
  final String? religion;
  final String? gender;
  final String? bloodGroup;
  final String? permanentAddress;
  final String? permanentThana;
  final String? permanentDivision;
  final String? permanentPostalCode;
  final String? presentAddress;
  final String? presentDivision;
  final String? presentThana;
  final String? presentPostelCode;
  final String? fatherName;
  final String? fatherNidNo;
  final String? fatherPhone;
  final String? motherName;
  final String? motherNidNo;
  final String? motherPhone;
  final String? localGuardianRelation;
  final String? localGuardianName;
  final String? localGuardianNidNo;
  final String? localGuardianPhone;
  final String? emergencyPhoneNo;

  StudentProfileUpdateRequestModel({
    this.name,
    this.email,
    this.phone,
    this.is2FaOn,
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
    this.presentDivision,
    this.presentThana,
    this.presentPostelCode,
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
  });

  factory StudentProfileUpdateRequestModel.fromJson(Map<String, dynamic> json) => StudentProfileUpdateRequestModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    is2FaOn: json["is_2fa_on"],
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
    presentDivision: json["present_division"],
    presentThana: json["present_thana"],
    presentPostelCode: json["present_postal_code"],
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
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "is_2fa_on": is2FaOn,
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
    "present_division": presentDivision,
    "present_thana": presentThana,
    "present_postal_code": presentPostelCode,
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
  };
}
