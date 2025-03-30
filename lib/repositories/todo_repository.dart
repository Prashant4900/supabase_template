import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_template/models/todo_model.dart';
import 'package:flutter_template/services/app_logger.dart';

class TodoRepository {
  final _todoRef = FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(TodoModel model) async {
    try {
      await _todoRef.add(model.toJson());
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoRef.doc(id).delete();
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteAllTodos() async {
    try {
      final todos = await fetchTodos();
      final ids = todos.map((todo) => todo.id).toList();

      for (final id in ids) {
        await _todoRef.doc(id).delete();
      }
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }

  Future<List<TodoModel>> fetchTodos() async {
    try {
      final querySnapshot = await _todoRef.get();
      return querySnapshot.docs
          .map<TodoModel>(TodoModel.fromDocSnapshot)
          .toList();
    } on FirebaseException catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    } catch (exception, stackTrace) {
      await AppLogger.error(exception, stackTrace);
      rethrow;
    }
  }
}
