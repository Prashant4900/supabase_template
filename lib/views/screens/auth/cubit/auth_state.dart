part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({required this.status, this.message, this.userModel});

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  final AuthStatus status;
  final UserModel? userModel;
  final String? message;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? userModel,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
