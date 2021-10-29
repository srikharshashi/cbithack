import 'package:bloc_custom_firebase/logic/authstatus_cubit/authstatus_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/image_cubit/image_cubit_dart_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/login/login_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/logout/logout_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/register/register_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/splash/splashscreen_cubit.dart';
import 'package:bloc_custom_firebase/logic/cubit/home_page_cubit.dart';
import 'package:bloc_custom_firebase/router.dart';
import 'package:bloc_custom_firebase/services/fb_auth.dart';
import 'package:bloc_custom_firebase/services/fb_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // final FirebaseApp _initialization = await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SplashscreenCubit(fb_service: FB_Service())),
        BlocProvider(
            create: (context) => LoginCubit(
                  databaseService: DatabaseService(),
                  fb_service: FB_Service(),
                )),
        BlocProvider(
            create: (context) => LogoutCubit(repossitory: FB_Service())),
        BlocProvider(
            create: (context) => RegisterCubit(fb_service: FB_Service())),
        BlocProvider(create: (context) => ImageCubitDartCubit()),
        BlocProvider(
          create: (context) => AuthstatusCubit(fb_service: FB_Service()),
        ),
        BlocProvider(
          create: (context) => HomePageCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
