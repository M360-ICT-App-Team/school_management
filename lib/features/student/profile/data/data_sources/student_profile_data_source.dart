

import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../../../../core/network/api_client.dart';
import '../model/student_profile_response_model.dart';
import '../model/student_profile_update_request_model.dart';

class StudentProfileDataSource { 

  static Future<Either<Failure, StudentProfileResponseModel>> getStudentProfile(
    
  ) async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.studentProfile,
        token: await AuthLocalDB.getToken(),
      );
      return Right(studentProfileResponseModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }


  static Future<Either<Failure, bool>> updateStudentProfile({ 
    required StudentProfileUpdateRequestModel payload,
    required List<SendFileModel> files
  }
    
  ) async {
    try {
      final result = await ApiClient.multipartRequestPatch(
        files: files,
        url: AppUrls.studentProfile,
        body: studentProfileUpdateRequestModelToJson(payload),
        token: await AuthLocalDB.getToken(),
      );
      return Right(result ! == null );
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

}