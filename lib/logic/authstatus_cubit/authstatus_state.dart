part of 'authstatus_cubit.dart';

abstract class AuthstatusState {}

class LoggedOut extends AuthstatusState {}

class LoggedIn extends AuthstatusState {
  User user;
  LoggedIn({
    required this.user,
  });
}
