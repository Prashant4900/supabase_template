import 'dart:developer' as dev;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static late FirebaseCrashlytics? _crashlytics;

  // AppLogger Initialize
  static Future<void> init() async {
    try {
      if (kDebugMode) {
        dev.log('AppLogger Initialize');
      } else {
        // App Logger Cloud Initialize
        _crashlytics = FirebaseCrashlytics.instance;
      }
    } catch (exception, stackTrace) {
      dev.log(exception.toString(), stackTrace: stackTrace);
    }
  }

  static void info(Object message, {String name = ''}) {
    if (kDebugMode) {
      dev.log('$message', time: DateTime.now(), name: name);
    } else {
      // Sync Logs with cloud
    }
  }

  static void log(Object message, {String name = ''}) {
    if (kDebugMode) {
      dev.log('$message', time: DateTime.now(), name: name);
    } else {
      // Sync Logs with cloud
      _crashlytics!.log(message.toString());
    }
  }

  static Future<void> error(
    dynamic exception,
    StackTrace stackTrace, {
    String name = '',
  }) async {
    if (kDebugMode) {
      dev.log(
        exception.toString(),
        stackTrace: stackTrace,
        time: DateTime.now(),
        name: name,
      );
    } else {
      // Sync Logs with cloud
      await _crashlytics!.recordError(exception, stackTrace);
    }
  }
}
