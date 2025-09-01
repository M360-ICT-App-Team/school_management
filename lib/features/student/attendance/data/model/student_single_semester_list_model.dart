// To parse this JSON data, do
//
//     final studentSingleSemesterListModel = studentSingleSemesterListModelFromJson(jsonString);

import 'dart:convert';

List<StudentSingleSemesterListModel> studentSingleSemesterListModelFromJson(String str) => List<StudentSingleSemesterListModel>.from(json.decode(str).map((x) => StudentSingleSemesterListModel.fromJson(x)));

String studentSingleSemesterListModelToJson(List<StudentSingleSemesterListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentSingleSemesterListModel {
  final int? subjectId;
  final String? subjectName;
  final String? status;
  final DateTime? attendanceTime;

  StudentSingleSemesterListModel({
    this.subjectId,
    this.subjectName,
    this.status,
    this.attendanceTime,
  });

  factory StudentSingleSemesterListModel.fromJson(Map<String, dynamic> json) => StudentSingleSemesterListModel(
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
    status: json["status"],
    attendanceTime: json["attendance_time"] == null ? null : DateTime.parse(json["attendance_time"]),
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_name": subjectName,
    "status": status,
    "attendance_time": attendanceTime?.toIso8601String(),
  };
}
