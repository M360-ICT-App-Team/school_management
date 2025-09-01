


import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/network/api_client.dart';
import '../model/current_semester_list_model.dart';
import '../model/student_single_semester_list_model.dart';

class CurrentSemesterService {

   Future<Either<Failure, List<CurrentSemesterListModel>>> getCurrentSemester() async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.studentCurrentSemester,
        token: await AuthLocalDB.getToken(),
      );
      return Right(currentSemesterListModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
   Future<Either<Failure, List<StudentSingleSemesterListModel>>> getSingleSemester(
        {required String? date}) async {
     try {
       final id = await AuthLocalDB.getSemesterId();
       final result = await ApiClient.get(
         url: '${AppUrls.studentCurrentSemester}/$id?date=$date',
         token: await AuthLocalDB.getToken(),
       );
       return Right(studentSingleSemesterListModelFromJson(jsonEncode(result)));
     } catch (e, stackTrace) {
       return Left(handleException(e, stackTrace));
     }
   }


}