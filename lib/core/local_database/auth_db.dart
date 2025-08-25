import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);

class AuthLocalDB {
  static final String authKey = "authKey_bpi";
static final String teacher = "teacher";
static final String student = "student";

  static final String roleKey = "roleKey_bpi";

  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<void> setToken(String token) async {
    await storage.write(key: authKey, value: token);
    if (kDebugMode) {
      print("Token set successfully");
    }
  }

  static Future<void> setRole(String role) async {
    await storage.write(key: roleKey, value: role);
    if (kDebugMode) {
      print("Role set successfully $role");
    }
  }

  static Future<String?> getToken() async {
    final token = await storage.read(key: authKey);
    if (token == null) {
      return null;
    }
    return token;
  }

  static Future<String?> getRole() async {
    final role = await storage.read(key: roleKey);
    if (role == null) {
      return null;
    }
    return role;
  }
    Future<void> setAccountStatus(String status) async {
    await storage.write(key: "accountStatus", value: status);
    if (kDebugMode) {
      print("accountStatus set successfully $status");
    }
  }
    Future<String?> getAccountStatus() async {
    final status = await storage.read(key: "accountStatus");
    return status;
  }

  static Future<void> removeToken() async {
    await storage.delete(key: authKey);
    await storage.delete(key: roleKey);
  }
}