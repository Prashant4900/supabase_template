part of 'todo_cubit.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  const TodoState({required this.status, required this.todos, this.message});

  factory TodoState.initial() {
    return const TodoState(status: TodoStatus.initial, todos: []);
  }

  final TodoStatus status;
  final List<TodoModel> todos;
  final String? message;

  TodoState copyWith({
    TodoStatus? status,
    List<TodoModel>? todos,
    String? message,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, todos, message];
}
