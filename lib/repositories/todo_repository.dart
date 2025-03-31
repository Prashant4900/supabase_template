import 'package:flutter_template/models/todo_model.dart';
import 'package:flutter_template/services/app_logger.dart';
import 'package:flutter_template/services/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoRepository {
  final _client = Supabase.instance.client;

  final _tableName = 'todos';

  Future<void> addTodo(TodoModel model) async {
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

  Future<void> deleteTodo(int id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id);
    } on PostgrestException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      throw Exception(exception.message);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  // Future<void> deleteAllTodos() async {
  //   try {
  //     final todos = await fetchTodos();
  //     final ids = todos.map((todo) => todo.id).toList();

  //     for (final id in ids) {
  //       await _todoRef.doc(id).delete();
  //     }
  //   } on FirebaseException catch (exception, stackTrace) {
  //     await AppLogger.error(exception, stackTrace);
  //     rethrow;
  //   } catch (exception, stackTrace) {
  //     await AppLogger.error(exception, stackTrace);
  //     rethrow;
  //   }
  // }

  Future<List<TodoModel>> fetchTodos() async {
    try {
      final result = await _client
          .from(_tableName)
          .select()
          .eq('user_id', AppPrefHelper.getUserID());

      return result.map(TodoModel.fromJson).toList();
    } on PostgrestException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      throw Exception(exception.message);
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }
}
