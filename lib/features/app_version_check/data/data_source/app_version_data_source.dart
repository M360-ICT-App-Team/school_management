import 'package:dartz/dartz.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/errors/exceptions.dart' show handleException;
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../model/app_version_model.dart';

class AppVersionDataSource {
  static Future<Either<Failure, AppVersionModel>> fetchAppVersion() async {
    try {
      final res = await ApiClient.get(url: AppUrls.appVersionUrl);
      return Right(AppVersionModel.fromJson(res));
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}