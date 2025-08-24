import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/api_client.dart';
import '../model/teacher_login_request_model.dart';
import '../model/teacher_login_response_model.dart';

class TeacherAuthRemoteDataSource { 

  static Future<Either<Failure, TeacherLoginResponseModel>> login({
    required TeacherLoginRequestModel payload,
  }) async {
    try {
      final result = await ApiClient.post(
        url: AppUrls.teacherLogin,
        body: teacherLoginRequestModelToJson(payload),
      );
      return Right(teacherLoginResponseModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

}