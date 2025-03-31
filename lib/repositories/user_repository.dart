import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/services/app_logger.dart';
import 'package:flutter_template/services/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final _client = Supabase.instance.client;
  final _tableName = 'users';

  Future<void> createUser(UserModel model) async {
    try {
      await _client.from(_tableName).insert(model.toJson());
    } on PostgrestException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      throw Exception(exception.message);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> updateUser(UserModel model) async {
    try {
      await _client
          .from(_tableName)
          .update(model.toJson())
          .eq('email', model.email);
    } on PostgrestException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      throw Exception(exception.message);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final result =
          await _client
              .from(_tableName)
              .select()
              .eq('email', AppPrefHelper.getEmail())
              .maybeSingle();

      return UserModel.fromJson(result ?? {});
    } on PostgrestException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      throw Exception(exception.message);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _client
          .from(_tableName)
          .delete()
          .eq('uid', AppPrefHelper.getUserID());
    } on PostgrestException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      throw Exception(exception.message);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }
}
