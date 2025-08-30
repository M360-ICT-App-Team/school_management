import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/network/api_client.dart';
import '../model/batch_over_view_teacher_response_model.dart';
import '../model/student_list_response_teacher_model.dart';

class TeacherAttendanceRemoteDataSource {
  //!for get batch over view
  static Future<Either<Failure, List<BatchOverViewTeacherResponseModel>>>
  getTeacherBatchOverView() async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.teacherAttendance,
        token: await AuthLocalDB.getToken(),
      );
      return Right(
        batchOverViewTeacherResponseModelFromJson(jsonEncode(result)),
      );
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //!for get student list
  static Future<Either<Failure, StudentListResponseTeacherModel>>
  getStudentList({
    required int? id,
    required DateTime? date,
    required int? subjectId,
    required int? branchId,
  }) async {
    try {
      String url;
      if (branchId == null) {
        url =
            "${AppUrls.teacherAttendance}/$id?date=$date&subject_offering_id=$subjectId";
      } else {
        url =
            "${AppUrls.teacherAttendance}/$id?branch_id=$branchId&date=$date&subject_offering_id=$subjectId";
      }
      final result = await ApiClient.get(
        url: url,
        token: await AuthLocalDB.getToken(),
      );
      return Right(studentListResponseTeacherModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

//!create attendance
  static Future<Either<Failure, void>> createAttendance({
    required List<AttendanceList> studentList,
    required int? subjectOfferingId,
    required DateTime? date,
    required int? batchSemesterId,
  }) async {
    try {
      final Map<String, dynamic> payload = {
        "attendances": studentList
            .map(
              (student) => {
                "enrollment_id": student.enrollmentId,
                "status": student.status!.value.toString(),
              },
            )
            .toList(),
        "subject_offering_id": subjectOfferingId,
        "date": date != null ? DateFormat("yyyy-MM-dd").format(date) : null,
        "batch_semester_id": batchSemesterId,
      };

      log("Create Attendance payload : ${(payload)}");

      final result = await ApiClient.post(
        body: jsonEncode(payload),
        url: AppUrls.teacherAttendance,
        token: await AuthLocalDB.getToken(),
      );
      return Right(result != null);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
  //!for update attendance
  static Future<Either<Failure, void>>
  updateAttendance({
    required int? id,
    required String? status,

  }) async {
    try {
     
      final result = await ApiClient.patch(
        url: AppUrls.teacherAttendance+"/$id",
        token: await AuthLocalDB.getToken(),
        body: jsonEncode({
          "status": status,
        }),
      );
      return Right(result!=null);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}


