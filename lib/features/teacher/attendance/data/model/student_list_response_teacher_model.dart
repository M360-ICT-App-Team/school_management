
import 'dart:convert';

import 'package:flutter/material.dart';

StudentListResponseTeacherModel studentListResponseTeacherModelFromJson(String str) => StudentListResponseTeacherModel.fromJson(json.decode(str));

String studentListResponseTeacherModelToJson(StudentListResponseTeacherModel data) => json.encode(data.toJson());

class StudentListResponseTeacherModel {
    final int? id;
    final int? subjectOfferingId;
    final String? subjectName;
    final DateTime? date;
    final bool? isSubmitted;
    final DateTime? createdAt;
    final int? totalStudents;
    final int? presentCount;
    final int? absentCount;
    final int? lateCount;
    final int? leaveCount;
    final int? noActionCount;
    final List<AttendanceList>? attendanceList;

    StudentListResponseTeacherModel({
        this.id,
        this.subjectOfferingId,
        this.subjectName,
        this.date,
        this.isSubmitted,
        this.createdAt,
        this.totalStudents,
        this.presentCount,
        this.absentCount,
        this.lateCount,
        this.leaveCount,
        this.noActionCount,
        this.attendanceList,
    });

    factory StudentListResponseTeacherModel.fromJson(Map<String, dynamic> json) => StudentListResponseTeacherModel(
        id: json["id"],
        subjectOfferingId: json["subject_offering_id"],
        subjectName: json["subject_name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        isSubmitted: json["is_submitted"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        totalStudents: json["total_students"],
        presentCount: json["present_count"],
        absentCount: json["absent_count"],
        lateCount: json["late_count"],
        leaveCount: json["leave_count"],
        noActionCount: json["no_action_count"],
        attendanceList: json["attendanceList"] == null ? [] : List<AttendanceList>.from(json["attendanceList"]!.map((x) => AttendanceList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subject_offering_id": subjectOfferingId,
        "subject_name": subjectName,
        "date": date?.toIso8601String(),
        "is_submitted": isSubmitted,
        "created_at": createdAt?.toIso8601String(),
        "total_students": totalStudents,
        "present_count": presentCount,
        "absent_count": absentCount,
        "late_count": lateCount,
        "leave_count": leaveCount,
        "no_action_count": noActionCount,
        "attendanceList": attendanceList == null ? [] : List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
    };
}

class AttendanceList {
    final String? rollNo;
    final String? studentName;
    final int? studentId;
    final int? enrollmentId;
    final int? studentAttendanceId;
    final int? attendanceSessionId;
     ValueNotifier<String>? status;

    AttendanceList({
        this.rollNo,
        this.studentName,
        this.studentId,
        this.enrollmentId,
        this.studentAttendanceId,
        this.attendanceSessionId,
        this.status,
    });

    factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
        rollNo: json["roll_no"],
        studentName: json["student_name"],
        studentId: json["student_id"],
        enrollmentId: json["enrollment_id"],
        studentAttendanceId: json["student_attendance_id"],
        attendanceSessionId: json["attendance_session_id"],
        status: ValueNotifier(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "roll_no": rollNo,
        "student_name": studentName,
        "student_id": studentId,
        "enrollment_id": enrollmentId,
        "student_attendance_id": studentAttendanceId,
        "attendance_session_id": attendanceSessionId,
        "status": status,
    };
}