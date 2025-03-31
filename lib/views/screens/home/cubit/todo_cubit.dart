import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/models/todo_model.dart';
import 'package:flutter_template/repositories/todo_repository.dart';
import 'package:flutter_template/setup.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState.initial());

  final _todoRepo = getIt<TodoRepository>();

  Future<void> addTodo(TodoModel model) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      await _todoRepo.addTodo(model);
      final todos = await _todoRepo.fetchTodos();
      emit(state.copyWith(status: TodoStatus.success, todos: todos));
    } catch (exception) {
      emit(
        state.copyWith(
          status: TodoStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> deleteTodo(int id) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      await _todoRepo.deleteTodo(id);
      final todos = await _todoRepo.fetchTodos();
      emit(state.copyWith(status: TodoStatus.success, todos: todos));
    } catch (exception) {
      emit(
        state.copyWith(
          status: TodoStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> getAllTodos() async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final todos = await _todoRepo.fetchTodos();
      emit(state.copyWith(status: TodoStatus.success, todos: todos));
    } catch (exception) {
      emit(
        state.copyWith(
          status: TodoStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }
}
