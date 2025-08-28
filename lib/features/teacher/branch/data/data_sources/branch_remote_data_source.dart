import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../../../../core/network/api_client.dart';
import '../model/branch_response_model.dart';

class BranchRemoteDataSource {
  static Future<Either<Failure, List<BranchResponseModel>>> getBranch() async {
    try {
      final result = await ApiClient.get(
        url: AppUrls.branchList,
        token: await AuthLocalDB.getToken(),
      );
      return Right(branchResponseModelFromJson(jsonEncode(result)));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}
