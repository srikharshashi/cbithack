import 'package:bloc_custom_firebase/logic/bloc/login/login_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/logout/logout_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/register/register_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/splash/splashscreen_cubit.dart';
import 'package:bloc_custom_firebase/router.dart';
import 'package:bloc_custom_firebase/services/repository.dart';
import 'package:bloc_custom_firebase/ui/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // final FirebaseApp _initialization = await Firebase.initializeApp();

}

class MyApp extends StatelessWidget {
  final AppRouter appRouter=AppRouter();
  final FB_Service fb_service=FB_Service();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashscreenCubit(fb_service: FB_Service())),
        BlocProvider(create: (context) => LoginCubit(fb_service: FB_Service(),)),
        BlocProvider(create: (context) => LogoutCubit(repossitory: FB_Service())),
        BlocProvider(create: (context)=> RegisterCubit(fb_service: FB_Service())),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        onGenerateRoute: appRouter.onGenerateRoute,

      ),
    );
  }
}
