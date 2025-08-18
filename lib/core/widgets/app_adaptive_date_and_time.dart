// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
Future<void> pickAdaptiveDateTime({
  required BuildContext context,
  required ValueNotifier<DateTime?> notifier,
  VoidCallback? onConfirmed,
}) async {
  final DateTime now = DateTime.now();
  final DateTime initialDateTime = notifier.value != null && notifier.value!.isAfter(now)
      ? notifier.value!
      : now;

  if (Platform.isIOS) {
    DateTime tempPickedDateTime = initialDateTime;
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
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minimumDate: now,
                  initialDateTime: initialDateTime,
                  onDateTimeChanged: (DateTime newDateTime) {
                    tempPickedDateTime = newDateTime;
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  if (tempPickedDateTime.isBefore(now)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a future date and time.')),
                    );
                    return;
                  }
                  notifier.value = tempPickedDateTime;
                  Navigator.of(context).pop();
                  if (onConfirmed != null) onConfirmed();
                },
              ),
            ],
          ),
        ),
      );
    } catch (e, k) {
      log("--------Error--------", error: e, stackTrace: k);
    }
  } else {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (finalDateTime.isBefore(now)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a future date and time.')),
          );
          return;
        }

        notifier.value = finalDateTime;
        if (onConfirmed != null) onConfirmed();
      }
    }
  }
}
