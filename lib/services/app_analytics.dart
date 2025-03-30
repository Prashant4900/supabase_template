import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AppAnalytics {
  AppAnalytics._();

  static FirebaseAnalytics? _analytics;

  static Future<void> init() async {
    _analytics ??= FirebaseAnalytics.instance;
  }

  static Future<void> logEvent(
    String name, {
    Map<String, Object>? parameters,
  }) async {
    if (!kDebugMode) {
      await _analytics!.logEvent(
        name: name,
        parameters: {
          ...parameters ?? {},
          'platform': Platform.operatingSystem,
          'logTime': DateTime.now().toIso8601String(),
        },
      );
    }
  }

  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (!kDebugMode) {
      await _analytics!.setUserProperty(name: name, value: value);
    }
  }

  static Future<void> setCurrentScreen({
    required String screenName,
    required String screenClass,
    Map<String, Object>? parameters,
  }) async {
    if (!kDebugMode) {
      await _analytics!.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
        parameters: {
          ...parameters ?? {},
          'platform': Platform.operatingSystem,
          'logTime': DateTime.now().toIso8601String(),
        },
      );
    }
  }

  static Future<void> setUserId(String userId) async {
    if (!kDebugMode) {
      await _analytics!.setUserId(id: userId);
    }
  }

  static Future<void> logLoginEvent() async {
    if (!kDebugMode) {
      await _analytics!.logLogin(loginMethod: 'email_login');
    }
  }

  static Future<void> logSignUpEvent() async {
    if (!kDebugMode) {
      await _analytics!.logSignUp(signUpMethod: 'email_signup');
    }
  }

  static Future<void> logShareEvent({
    required String contentType,
    required String itemId,
    required String method,
  }) async {
    if (!kDebugMode) {
      await _analytics!.logShare(
        contentType: contentType,
        itemId: itemId,
        method: method,
      );
    }
  }

  static Future<void> logSearchEvent({required String searchTerm}) async {
    if (!kDebugMode) {
      await _analytics!.logSearch(searchTerm: searchTerm);
    }
  }

  static Future<void> logAppOpen({Map<String, Object>? parameters}) async {
    if (!kDebugMode) {
      await _analytics!.logAppOpen(
        parameters: {
          ...parameters ?? {},
          'platform': Platform.operatingSystem,
          'logTime': DateTime.now().toIso8601String(),
        },
      );
    }
  }

  static Future<void> reset() async {
    if (!kDebugMode) {
      await _analytics!.resetAnalyticsData();
    }
  }
}
