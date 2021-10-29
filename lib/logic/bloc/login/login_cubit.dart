import 'package:bloc/bloc.dart';
import 'package:bloc_custom_firebase/models/user_model.dart';
import 'package:bloc_custom_firebase/services/fb_auth.dart';
import 'package:bloc_custom_firebase/services/fb_database.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  FB_Service fb_service;
  DatabaseService databaseService;

  LoginCubit({required this.fb_service, required this.databaseService})
      : super(LoginInitial());

  void signin(String email, String password) async {
    emit(LoginLoad());
    fb_service.signin(email, password).then((value) {
      if (value) {
        //go to database and fecth user data
         databaseService.getusermap(email).then((value) {
          User user = User.frommap(value);

          emit(LoginSucesss(user: user));
        });
        
      } else {
        emit(LoginFail());
      }
    });
  }

 
}
