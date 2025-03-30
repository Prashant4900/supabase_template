import 'package:flutter_template/repositories/auth_repository.dart';
import 'package:flutter_template/repositories/todo_repository.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt
    ..registerSingleton<AuthRepository>(AuthRepository())
    ..registerSingleton<UserRepository>(UserRepository())
    ..registerSingleton<TodoRepository>(TodoRepository());
}
