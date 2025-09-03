import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../constants/app_exception_messages.dart';
import 'failures.dart';


class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}


Failure handleException(dynamic e, StackTrace stackTrace) {
  if (kDebugMode) {
    log("_____________________Error____________________", error: e, stackTrace: stackTrace);
  }

  if (e is FormatException) {
    return ApiFailure(AppExceptionMessage.format);
  } else if (e is TypeError) {
    return ApiFailure(AppExceptionMessage.type);
  } else if (e is TimeoutException) {
    return ApiFailure(AppExceptionMessage.timeout);
  } else if (e is SocketException) {
    return ApiFailure(AppExceptionMessage.socket);
  } else if (e is ServerException) {
    return ApiFailure(e.message);
  } else {
    return ApiFailure(AppExceptionMessage.unknown);
  }
}