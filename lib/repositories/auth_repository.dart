import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/services/app_logger.dart';
import 'package:flutter_template/services/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final _auth = Supabase.instance.client.auth;

  Future<User?> get currentUser async => _auth.currentUser;

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.resetPasswordForEmail(email);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _auth.signUp(
        email: email,
        password: password,
        data: {'display_name': name},
      );

      await AppPrefHelper.setUserID(user.user?.id ?? '');
      await AppPrefHelper.setEmail(user.user?.email ?? '');
      await AppPrefHelper.setDisplayName(name);

      final userModel = UserModel(
        uid: user.user?.id ?? '',
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      return userModel;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final user = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      await AppPrefHelper.setUserID(user.user?.id ?? '');
      await AppPrefHelper.setEmail(user.user?.email ?? '');
      // await AppPrefHelper.setDisplayName(user.user?.displayName ?? '');
    } on AuthException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);

      if (exception.code == 'invalid_credentials') {
        throw Exception('Invalid login credentials');
      }

      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await AppPrefHelper.signOut();
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }
}
