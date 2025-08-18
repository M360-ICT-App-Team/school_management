import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

convertDateTime(DateTime? dateTime, String? format) {
  /* 
  format[
    'yyyy-MM-dd'
    'EEEE, MMM d, yyyy'
    'MM-dd-yyyy HH:mm'
    'MMM d, h:mm a'
    'E, d MMM yyyy HH:mm:ss'
  ]
  */
  if (dateTime == null) {
    return null;
  }
  final dateFormatter = DateFormat(format ?? "dd MMM yyyy");
  return dateFormatter.format(dateTime.toLocal());
}

//dd-MM-yy 12-02-25
String? formatDateTime({dynamic dateTime, String? format}) {
  if (dateTime == null) {
    return null;
  }

  try {
    final dateFormatter = DateFormat(format ?? 'dd MMM yyyy');
    if (dateTime is DateTime) {
      return dateFormatter.format(dateTime.toLocal());
    }

    final DateTime parsedDate = DateTime.parse(dateTime);
    return dateFormatter.format(parsedDate);
  } catch (e) {
    if (kDebugMode) {
      print("object convertDateTime e: $e");
    }
    return null;
  }
}

String? formatTime(String? departureTime) {
  if (departureTime == null || departureTime.isEmpty) {
    return null;
  }

  try {
    // Attach an arbitrary date to make the string a valid ISO 8601 datetime
    final isoString = '2000-01-01T$departureTime';

    final dateTime = DateTime.parse(isoString);
    final formatted = DateFormat.jm().format(dateTime.toLocal());

    return formatted;
  } catch (e) {
    if (kDebugMode) {
      print("Error parsing time: $e");
    }
    return null;
  }
}

bool availablePartialPayment(DateTime? departureDate) {
  if (departureDate == null) {
    return false;
  }

  try {
    final now = DateTime.now();
    final difference = departureDate.difference(now).inDays;
    return difference >= 10;
  } catch (e) {
    return false;
  }
}
