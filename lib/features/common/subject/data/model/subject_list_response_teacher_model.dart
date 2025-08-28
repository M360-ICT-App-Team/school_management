
import 'dart:convert';

List<SubjectListResponseTeacherModel> subjectListResponseTeacherModel(String str) => List<SubjectListResponseTeacherModel>.from(json.decode(str).map((x) => SubjectListResponseTeacherModel.fromJson(x)));

class SubjectListResponseTeacherModel {
    final int? subjectOfferingId;
    final String? subjectName;
    final int? subjectId;
    final String? teacherName;
    final String? batchSemesterName;
    final int? batchSemesterId;
    final int? id;

    SubjectListResponseTeacherModel({
        this.subjectOfferingId,
        this.subjectName,
        this.subjectId,
        this.teacherName,
        this.batchSemesterName,
        this.batchSemesterId,
        this.id,
    });

    factory SubjectListResponseTeacherModel.fromJson(Map<String, dynamic> json) => SubjectListResponseTeacherModel(
        subjectOfferingId: json["subject_offering_id"],
        subjectName: json["subject_name"],
        subjectId: json["subject_id"],
        teacherName: json["teacher_name"],
        batchSemesterName: json["batch_semester_name"],
        batchSemesterId: json["batch_semester_id"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "subject_offering_id": subjectOfferingId,
        "subject_name": subjectName,
        "subject_id": subjectId,
        "teacher_name": teacherName,
        "batch_semester_name": batchSemesterName,
        "batch_semester_id": batchSemesterId,
        "id": id,
    };
}