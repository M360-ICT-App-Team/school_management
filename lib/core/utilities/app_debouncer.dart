import 'dart:async';
import 'package:flutter/material.dart';

class AppDebouncer {
  final int? milliseconds;
  Timer? _timer;

  AppDebouncer({this.milliseconds});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds ?? 200), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

//for debouncing example
// final debouncer = AppDebouncer(milliseconds: 500);
// debouncer.run(() {
//   // do something
// });
