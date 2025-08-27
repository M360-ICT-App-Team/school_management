import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/network/api_client.dart';
import '../model/batch_over_view_teacher_response_model.dart';
import '../model/student_list_response_teacher_model.dart';

class TeacherAttendanceRemoteDataSource { 

  //!for get batch over view
  static Future<Either<Failure, List<BatchOverViewTeacherResponseModel>>> getTeacherBatchOverView(
    
  ) async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.teacherAttendance,
        token: await AuthLocalDB.getToken(),
      );
      return Right(batchOverViewTeacherResponseModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //!for get student list
    static Future<Either<Failure, List<StudentListResponseTeacherModel>>> getStudentList({ 
      required int id,
      required DateTime? date,
      required int subjectId
    }
    
  ) async {
    try {
      final result = await ApiClient.get(
        url: "${AppUrls.teacherAttendance}/$id?date=$date&subject_offering_id=$subjectId",
        token: await AuthLocalDB.getToken(),
      );
      return Right(studentListResponseTeacherModel(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

}