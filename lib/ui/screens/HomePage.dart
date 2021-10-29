import 'dart:ui';

import 'package:bloc_custom_firebase/constants.dart';
import 'package:bloc_custom_firebase/logic/authstatus_cubit/authstatus_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/logout/logout_cubit.dart';
import 'package:bloc_custom_firebase/logic/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogOutSucess)
          Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
        else
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Logout Failed!")));
      },
      child: SafeArea(
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            return BlocBuilder<AuthstatusCubit, AuthstatusState>(
              builder: (context, auth_state) {
                if (auth_state is LoggedIn)
                  return Scaffold(
                    body: Container(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "lib/assets/img/charminar.jpeg",
                            fit: BoxFit.cover,
                          ),
                          Positioned.fill(
                            child: Center(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2.0,
                                  sigmaY: 2.0,
                                ),
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              height: 100,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(FontAwesomeIcons.bars),
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                (auth_state as LoggedIn)
                                                    .user
                                                    .photoURL),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 650,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Container(
                                              child: Text(
                                                "Hey ${auth_state.user.name}",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                else
                  return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
