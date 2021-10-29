part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginFail extends LoginState {}

class LoginSucesss extends LoginState {
  String email;
  LoginSucesss({
    required this.email,
  });
}

class UnAuthenticated extends LoginState {
  // List<Object?> get props => throw UnimplementedError();
}

class LoginLoad extends LoginState {}
