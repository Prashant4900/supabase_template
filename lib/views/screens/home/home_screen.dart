import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/models/todo_model.dart';
import 'package:flutter_template/services/app_prefs.dart';
import 'package:flutter_template/views/components/body_widget.dart';
import 'package:flutter_template/views/screens/home/cubit/todo_cubit.dart';
import 'package:go_router/go_router.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.lang.homeScreen)),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final todo = await addTodoDialog(context);
              if (todo == null) return;

              if (!context.mounted) return;

              final model = TodoModel(
                userID: AppPrefHelper.getUserID(),
                name: todo,
                updatedAt: DateTime.now(),
                createdAt: DateTime.now(),
              );

              await context.read<TodoCubit>().addTodo(model);
            },
            child: const Icon(Icons.add),
          ),
          body: BodyWidget(
            isLoading: state.status == TodoStatus.loading,
            child:
                state.todos.isEmpty
                    ? Center(child: Text(context.lang.noTodoFounds))
                    : ListView.builder(
                      itemCount: state.todos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(todo.name),
                          leading: CircleAvatar(
                            radius: 16,
                            child: Text('$index'),
                          ),
                          trailing: IconButton(
                            onPressed:
                                () => context.read<TodoCubit>().deleteTodo(
                                  todo.id!,
                                ),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        );
                      },
                    ),
          ),
        );
      },
    );
  }

  Future<String?> addTodoDialog(BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (_) {
        return AlertDialog.adaptive(
          title: Text(context.lang.addTodo),
          content: Material(
            color: Colors.transparent,
            child: TextFormField(
              controller: _todoController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: context.lang.addTodo,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(context.lang.close),
            ),
            TextButton(
              onPressed: () {
                final text = _todoController.text;
                context.pop(text);
              },
              child: Text(context.lang.add),
            ),
          ],
        );
      },
    );
  }
}
