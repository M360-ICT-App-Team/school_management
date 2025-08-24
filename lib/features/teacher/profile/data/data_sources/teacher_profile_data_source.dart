import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/network/api_client.dart';
import '../model/teacher_profile_response_model.dart';

class TeacherProfileDataSource { 

  static Future<Either<Failure, TeacherProfileResponseModel>> getTeacherProfile(
    
  ) async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.teacherProfile,
        token: await AuthLocalDB.getToken(),
      );
      return Right(teacherProfileResponseModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }


}