part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginFail extends LoginState {}

class LoginSucesss extends LoginState {
  User user;
  LoginSucesss({
    required this.user,
  });
}

class UnAuthenticated extends LoginState {
  // List<Object?> get props => throw UnimplementedError();
}

class LoginLoad extends LoginState {}
