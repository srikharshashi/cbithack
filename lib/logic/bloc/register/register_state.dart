part of 'register_cubit.dart';


abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoad extends RegisterState {}

class RegisterSuccess extends RegisterState {
  String name;
  String email;
  RegisterSuccess({
    required this.name,
    required this.email,
  });
  
}

class RegisterFail extends RegisterState {}
