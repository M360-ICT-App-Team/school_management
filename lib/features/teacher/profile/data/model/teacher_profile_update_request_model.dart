import 'dart:convert';

TeacherProfileUpdateRequestModel teacherProfileUpdateRequestModelFromJson(
  String str,
) => TeacherProfileUpdateRequestModel.fromJson(json.decode(str));

String teacherProfileUpdateRequestModelToJson(
  TeacherProfileUpdateRequestModel data,
) => json.encode(data.toJson());

class TeacherProfileUpdateRequestModel {
  String? email;
  String? phone;
  String? fatherName;
  String? motherName;
  String? presentAddress;
  String? permanentAddress;
  String? bloodGroup;

  TeacherProfileUpdateRequestModel({
    this.email,
    this.phone,
    this.fatherName,
    this.motherName,
    this.presentAddress,
    this.permanentAddress,
    this.bloodGroup,
  });

  TeacherProfileUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    bloodGroup = json['blood_group'];
  }
  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "father_name": fatherName ?? "",
    "mother_name": motherName ?? "",
    "present_address": presentAddress ?? "",
    "permanent_address": permanentAddress ?? "",
    "blood_group": bloodGroup ?? "",
  };
}
