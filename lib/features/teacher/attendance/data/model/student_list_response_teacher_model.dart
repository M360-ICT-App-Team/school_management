
import 'dart:convert';

import 'package:flutter/widgets.dart';

List<StudentListResponseTeacherModel> studentListResponseTeacherModel(String str) => List<StudentListResponseTeacherModel>.from(json.decode(str).map((x) => StudentListResponseTeacherModel.fromJson(x)));

class StudentListResponseTeacherModel {
    final String? rollNo;
    final String? studentName;
    final int? studentId;
    final int? enrollmentId;
    final dynamic attendanceSessionId;
    final dynamic studentAttendanceId;
    final String? subjectOfferingId;
    final String? subjectName;
    final ValueNotifier<String>? status;

    StudentListResponseTeacherModel({
        this.rollNo,
        this.studentName,
        this.studentId,
        this.enrollmentId,
        this.attendanceSessionId,
        this.studentAttendanceId,
        this.subjectOfferingId,
        this.subjectName,
        this.status,
    });

    factory StudentListResponseTeacherModel.fromJson(Map<String, dynamic> json) => StudentListResponseTeacherModel(
        rollNo: json["roll_no"],
        studentName: json["student_name"],
        studentId: json["student_id"],
        enrollmentId: json["enrollment_id"],
        attendanceSessionId: json["attendance_session_id"],
        studentAttendanceId: json["student_attendance_id"],
        subjectOfferingId: json["subject_offering_id"],
        subjectName: json["subject_name"],
        status: ValueNotifier(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "roll_no": rollNo,
        "student_name": studentName,
        "student_id": studentId,
        "enrollment_id": enrollmentId,
        "attendance_session_id": attendanceSessionId,
        "student_attendance_id": studentAttendanceId,
        "subject_offering_id": subjectOfferingId,
        "subject_name": subjectName,
        "status": status,
    };
}