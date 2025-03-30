import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/services/app_logger.dart';
import 'package:flutter_template/services/app_prefs.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Future<User?> get currentUser async => _auth.currentUser;

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<UserModel> signUp(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await AppPrefHelper.setUserID(user.user?.uid ?? '');
      await AppPrefHelper.setEmail(user.user?.email ?? '');
      await AppPrefHelper.setDisplayName(user.user?.displayName ?? '');

      final userModel = UserModel(
        userID: user.user?.uid ?? '',
        email: email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastSignIn: DateTime.now(),
      );

      return userModel;
    } on FirebaseAuthException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await AppPrefHelper.setUserID(user.user?.uid ?? '');
      await AppPrefHelper.setEmail(user.user?.email ?? '');
      await AppPrefHelper.setDisplayName(user.user?.displayName ?? '');
    } on FirebaseAuthException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
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
    } on FirebaseAuthException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
      await AppPrefHelper.signOut();
    } on FirebaseAuthException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }
}
