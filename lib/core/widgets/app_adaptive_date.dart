import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

/// Utility to strip time from a DateTime (set to midnight)
DateTime stripTime(DateTime date) => DateTime(date.year, date.month, date.day);

/// Adaptive date picker that works on both iOS and Android
Future<void> pickAdaptiveDate({
  required BuildContext context,
  required ValueNotifier<DateTime?> notifier,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  VoidCallback? onConfirmed,
}) async {
  if (Platform.isIOS) {
    DateTime tempPickedDate = stripTime(initialDate);
    try {
      await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: AppSizes.height(context, 350),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: AppSizes.height(context, 250),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: stripTime(initialDate),
                  minimumDate: stripTime(firstDate),
                  maximumDate: stripTime(lastDate),
                  onDateTimeChanged: (DateTime newDate) {
                    tempPickedDate = stripTime(newDate);
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  notifier.value = tempPickedDate;
                  Navigator.of(context).pop();
                  if (onConfirmed != null) onConfirmed();
                },
              )
            ],
          ),
        ),
      );
    } catch (e, k) {
      log("--------Error--------", error: e, stackTrace: k);
    }
  } else {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate != null) {
      notifier.value = selectedDate;
      if (onConfirmed != null) onConfirmed();
    }
  }
}




Future<DateTimeRange?> pickDateRange(BuildContext context) async {
  final DateTime now = DateTime.now();
  final DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(now.year - 5),
    lastDate: DateTime(now.year + 5),
    initialDateRange: DateTimeRange(
      start: now,
      end: now.add(const Duration(days: 7)),
    ),
    builder: (context, child) {
      return child!;
    },
  );

  return picked;
}




