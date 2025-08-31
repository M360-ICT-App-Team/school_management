enum AttendanceStatus { no_action, present, late, leave, absent }

extension AttendanceStatusExtension on AttendanceStatus {
  String get value {
    switch (this) {
      case AttendanceStatus.no_action:
        return "সিদ্ধান্ত হয়নি";
      case AttendanceStatus.present:
        return "উপস্থিত";
      case AttendanceStatus.late:
        return "দেরি";
      case AttendanceStatus.leave:
        return "ছুটি";
      case AttendanceStatus.absent:
        return "অনুপস্থিত";
    }
  }
}

AttendanceStatus attendanceStatusFromString(String status) {
  switch (status) {
    case "present":
      return AttendanceStatus.present;
    case "late":
      return AttendanceStatus.late;
    case "leave":
      return AttendanceStatus.leave;
    case "absent":
      return AttendanceStatus.absent;
    case "no_action":
    default:
      return AttendanceStatus.no_action;
  }
}
