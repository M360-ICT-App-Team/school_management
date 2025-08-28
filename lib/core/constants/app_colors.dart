import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xe80457c2);
  static const backgroundColor = Color(0xfff0f8ff);

  static Color secondary = const Color.fromARGB(255, 9, 82, 165);
  static const bg = Color.fromARGB(255, 247, 250, 252);
  static const white = Colors.white;
  static const lightGrey = Color.fromARGB(255, 203, 203, 203);
  static const grey = Color.fromARGB(255, 196, 196, 196);
  static const black = Colors.black;
  static const textBlack1 = Colors.black87;
  static const textBlack2 = Colors.black54;
  static Color fill = Colors.grey.shade100;
  static const Color subtitle = Colors.grey;
  static const Color active = Colors.greenAccent;
  static const Color blue = Color(0xff7dbcff);
  static const Color green = Color.fromARGB(255, 0, 154, 80);
  static const Color red = Colors.redAccent;
  static const Color orange = Colors.orange;
  static Color? blueShade = Colors.blue[100];

  static Color error(context) => Theme.of(context).colorScheme.error;

  static LinearGradient gradient({
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) => LinearGradient(
    colors: [Colors.red, const Color.fromARGB(255, 181, 49, 40)],
    stops: [0, 1],
    begin: begin ?? Alignment.topLeft,
    end: end ?? Alignment.bottomRight,
  );

  static final appShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    blurRadius: 10,
    offset: const Offset(0, 2),
  );

  static final Map<String, Color> statusColors = {
    "no_action": Colors.green,
    "present": Colors.green,
    "late": Colors.blue,
    "absent": Colors.red,
  };

  static Color status(String? status) {
    try {
      final lowerStatus = status?.toLowerCase().trim();
      if (lowerStatus == null) return Colors.black;
      return statusColors[lowerStatus] ?? Colors.black;
    } on Exception catch (e) {
      if (kDebugMode) {
        print("object convert status color e: $e");
      }
      return Colors.black;
    }
  }
}
