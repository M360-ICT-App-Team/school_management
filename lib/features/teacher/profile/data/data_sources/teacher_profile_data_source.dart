import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../../../../core/network/api_client.dart';
import '../model/teacher_profile_response_model.dart';
import '../model/teacher_profile_update_request_model.dart';

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


  static Future<Either<Failure, bool>> updateTeacherProfile({ 
    required TeacherProfileUpdateRequestModel payload,
    required List<SendFileModel> files
  }
    
  ) async {
    try {
      final result = await ApiClient.multipartRequestPatch(
        files: files,
        url: AppUrls.teacherProfile,
        body: teacherProfileUpdateRequestModelToJson(payload),
        token: await AuthLocalDB.getToken(),
      );
      return Right(result ! == null );
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

}