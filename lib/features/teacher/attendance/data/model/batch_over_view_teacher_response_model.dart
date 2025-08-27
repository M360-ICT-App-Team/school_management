 
 import 'dart:convert';

List<BatchOverViewTeacherResponseModel> batchOverViewTeacherResponseModelFromJson(String str) => List<BatchOverViewTeacherResponseModel>.from(json.decode(str).map((x) => BatchOverViewTeacherResponseModel.fromJson(x)));

class BatchOverViewTeacherResponseModel {
    final int? id;
    final String? batch;
    final String? semester;
    final String? subject;
    final String? students;
    final String? attendancePending;
    final int? subjectOfferingId;
    final String? status;

    BatchOverViewTeacherResponseModel({
        this.id,
        this.batch,
        this.semester,
        this.subject,
        this.students,
        this.attendancePending,
        this.subjectOfferingId,
        this.status,
    });

    factory BatchOverViewTeacherResponseModel.fromJson(Map<String, dynamic> json) => BatchOverViewTeacherResponseModel(
        id: json["id"],
        batch: json["batch"],
        semester: json["semester"],
        subject: json["subject"],
        students: json["students"],
        attendancePending: json["attendance_pending"],
        subjectOfferingId: json["subject_offering_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "batch": batch,
        "semester": semester,
        "subject": subject,
        "students": students,
        "attendance_pending": attendancePending,
        "subject_offering_id": subjectOfferingId,
        "status": status,
    };
}