import 'dart:async' show Timer;
import 'package:flutter/services.dart' show VoidCallback;

/// A simple debouncer
/// Use 500 milliseconds as a default delay period.
/// ```dart
/// final debouncer = Debouncer(milliseconds: 1000);
/// debouncer.run(callback);
///
/// ```
class Debouncer {
  final int milliseconds;

  Debouncer({
    this.milliseconds = 500,
  });

  Timer? _timer;

  void run(VoidCallback callback) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      callback,
    );
  }
}
