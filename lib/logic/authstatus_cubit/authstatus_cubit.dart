import 'package:bloc/bloc.dart';
import 'package:bloc_custom_firebase/models/user_model.dart';
import 'package:bloc_custom_firebase/services/fb_auth.dart';
import 'package:equatable/equatable.dart';

part 'authstatus_state.dart';

class AuthstatusCubit extends Cubit<AuthstatusState> {
  AuthstatusCubit({required this.fb_service}) : super(LoggedOut()) {
    check();
  }
  FB_Service fb_service;

  void check() {
    if (fb_service.checkSignin()) {
      // emit(LoggedIn(user: user));
    }
  }

  void auth(String name, String email, String photoURL) {
    User user = User(email: email, name: name, photoURL: photoURL);
    emit(LoggedIn(user: user));
  }

  void logout() {
    emit(LoggedOut());
  }
}
