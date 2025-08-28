import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/network/api_client.dart';
import '../model/subject_list_response_teacher_model.dart';

class SubjectRemoteDataSource {
  static Future<Either<Failure, List<SubjectListResponseTeacherModel>>>
  getSubject() async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.offeringSubject,
        token: await AuthLocalDB.getToken(),
      );
      return Right(subjectListResponseTeacherModel(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}
