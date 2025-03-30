import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/repositories/auth_repository.dart';
import 'package:flutter_template/repositories/todo_repository.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/setup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  final _authRepo = getIt<AuthRepository>();
  final _userRepo = getIt<UserRepository>();
  final _todoRepo = getIt<TodoRepository>();

  Future<void> init() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      emit(state.copyWith(status: AuthStatus.success));
    } catch (exception) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> sendForgotPasswordEmail(String email) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepo.forgotPassword(email);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (exception) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepo.signIn(email, password);
      final model = await _userRepo.getUser();
      final userModel = model?.copyWith(lastSignIn: DateTime.now());
      await _userRepo.updateUser(userModel!);

      emit(state.copyWith(status: AuthStatus.success, userModel: userModel));
    } catch (exception) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> signup(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final userModel = await _authRepo.signUp(email, password);
      await _userRepo.createUser(userModel);

      emit(state.copyWith(status: AuthStatus.success, userModel: userModel));
    } catch (exception) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepo.signOut();
      emit(state.copyWith(status: AuthStatus.initial));
    } catch (exception) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _todoRepo.deleteAllTodos();
      await _userRepo.deleteUser();
      await _authRepo.deleteAccount();
      emit(state.copyWith(status: AuthStatus.initial));
    } catch (exception) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: exception.toString(),
        ),
      );
    }
  }
}
