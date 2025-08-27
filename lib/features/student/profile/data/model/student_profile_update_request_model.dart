import 'dart:convert';

StudentProfileUpdateRequestModel StudentProfileUpdateRequestModelFromJson(
  String str,
) => StudentProfileUpdateRequestModel.fromJson(json.decode(str));

String StudentProfileUpdateRequestModelToJson(
  StudentProfileUpdateRequestModel data,
) => json.encode(data.toJson());

class StudentProfileUpdateRequestModel {
  String? email;
  String? phone;
  String? fatherName;
  String? motherName;
  String? presentAddress;
  String? permanentAddress;
  String? bloodGroup;

  StudentProfileUpdateRequestModel({
    this.email,
    this.phone,
    this.fatherName,
    this.motherName,
    this.presentAddress,
    this.permanentAddress,
    this.bloodGroup,
  });

  StudentProfileUpdateRequestModel.fromJson(Map<String, dynamic> json) {
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
