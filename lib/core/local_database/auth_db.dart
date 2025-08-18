import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);

class AuthLocalDB {
  static final String authKey = "authKeyLet'sFlyBD";

  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<void> setToken(String token) async {
    await storage.write(key: authKey, value: token);
    if (kDebugMode) {
      print("Token set successfully");
    }
  }

  static Future<String?> getToken() async {
    final token = await storage.read(key: authKey);
    if (token == null) {
      return null;
    }
    return token;
  }

  static Future<void> removeToken() async {
    await storage.delete(key: authKey);
  }
}