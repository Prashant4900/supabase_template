import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppRemoteConfig {
  AppRemoteConfig._();

  static FirebaseRemoteConfig? _remoteConfig;

  static Future<void> init() async {
    _remoteConfig ??= FirebaseRemoteConfig.instance;
  }
}
