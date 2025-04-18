import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/repositories/auth_repository.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/services/app_prefs.dart';
import 'package:flutter_template/setup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  final _authRepo = getIt<AuthRepository>();
  final _userRepo = getIt<UserRepository>();

  Future<void> init() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      if (AppPrefHelper.getEmail().isNotEmpty) {
        final userModel = await _userRepo.getUser();
        emit(state.copyWith(status: AuthStatus.success, userModel: userModel));
      }

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

  Future<void> updateUser(UserModel? user) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final userModel = user?.copyWith(updatedAt: DateTime.now());
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

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final userModel = await _authRepo.signUp(
        name: name,
        email: email,
        password: password,
      );
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
}
