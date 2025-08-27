import 'package:flutter_dotenv/flutter_dotenv.dart';

final bool isLive = false;

class AppUrls {
  static String currentVersion = "1.0.0"; //ex: "1.0.19"
  static String imageUrl = dotenv.env['IMAGE_URL']!;

  static String baseUrl = isLive 
      ? dotenv.env['BASE_URL']!
      : "http://10.10.220.45:9501/api/v1";


//!for teacher
  static String teacherLogin = '$baseUrl/auth/teacher/login';
  static String teacherProfile = '$baseUrl/teacher/profile';
  static String teacherAttendance = '$baseUrl/teacher/student-attendance';

//!for student
  static String studentLogin = '$baseUrl/auth/student/login';
  static String studentProfile = '$baseUrl/student/profile';
}