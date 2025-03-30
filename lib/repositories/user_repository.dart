import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/services/app_logger.dart';
import 'package:flutter_template/services/app_prefs.dart';

class UserRepository {
  final _userRef = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel model) async {
    try {
      await _userRef.doc(model.userID).set(model.toJson());
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final doc = await _userRef.doc(AppPrefHelper.getUserID()).get();

      if (!doc.exists) return null;

      return UserModel.fromDocSnapshot(doc);
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> updateUser(UserModel model) async {
    try {
      await _userRef.doc(model.userID).update(model.toJson());
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _userRef.doc(AppPrefHelper.getUserID()).delete();
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }
}
