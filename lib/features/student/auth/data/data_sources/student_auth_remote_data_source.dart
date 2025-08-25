

import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/api_client.dart';
import '../model/student_login_request_model.dart';
import '../model/student_login_response_model.dart';

class StudentAuthRemoteDataSource { 

  static Future<Either<Failure, StudentLoginResponseModel>> loginStudent({
    required StudentLoginRequestModel payload,
  }) async {
    try {
      final result = await ApiClient.post(
        url: AppUrls.studentLogin,
        body: studentLoginRequestModelToJson(payload),
      );
      return Right(studentLoginResponseModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

}