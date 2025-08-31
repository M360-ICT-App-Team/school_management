// To parse this JSON data, do
//
//     final currentSemesterListModel = currentSemesterListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CurrentSemesterListModel> currentSemesterListModelFromJson(String str) => List<CurrentSemesterListModel>.from(json.decode(str).map((x) => CurrentSemesterListModel.fromJson(x)));

String currentSemesterListModelToJson(List<CurrentSemesterListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrentSemesterListModel {
  final int id;
  final String department;
  final dynamic departmentShortName;
  final int departmentId;
  final String batch;
  final String semester;
  final DateTime startDate;
  final DateTime endDate;
  final String totalPresent;
  final String totalAbsent;
  final String totalNoAction;
  final String totalLeave;
  final String totalLate;
  final String status;

  CurrentSemesterListModel({
    required this.id,
    required this.department,
    required this.departmentShortName,
    required this.departmentId,
    required this.batch,
    required this.semester,
    required this.startDate,
    required this.endDate,
    required this.totalPresent,
    required this.totalAbsent,
    required this.totalNoAction,
    required this.totalLeave,
    required this.totalLate,
    required this.status,
  });

  factory CurrentSemesterListModel.fromJson(Map<String, dynamic> json) => CurrentSemesterListModel(
    id: json["id"],
    department: json["department"],
    departmentShortName: json["department_short_name"],
    departmentId: json["department_id"],
    batch: json["batch"],
    semester: json["semester"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    totalPresent: json["total_present"],
    totalAbsent: json["total_absent"],
    totalNoAction: json["total_no_action"],
    totalLeave: json["total_leave"],
    totalLate: json["total_late"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department": department,
    "department_short_name": departmentShortName,
    "department_id": departmentId,
    "batch": batch,
    "semester": semester,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "total_present": totalPresent,
    "total_absent": totalAbsent,
    "total_no_action": totalNoAction,
    "total_leave": totalLeave,
    "total_late": totalLate,
    "status": status,
  };
}
