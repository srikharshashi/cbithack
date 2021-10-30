import 'dart:ui';

import 'package:bloc_custom_firebase/constants.dart';
import 'package:bloc_custom_firebase/logic/authstatus_cubit/authstatus_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/logout/logout_cubit.dart';
import 'package:bloc_custom_firebase/logic/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatelessWidget {
  String _url = "https://www.google.com/search?q=";

  void _launchURL(String city) async => await canLaunch(_url)
      ? await launch(_url + city)
      : throw 'Could not launch $_url';

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
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.white)),
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
                                      // decoration: BoxDecoration(
                                      //     border:
                                      //         Border.all(color: Colors.white)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.bars,
                                            color: Colors.white,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<LogoutCubit>()
                                                  .logout();
                                              context
                                                  .read<AuthstatusCubit>()
                                                  .logout();
                                            },
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                  (auth_state as LoggedIn)
                                                      .user
                                                      .photoURL),
                                            ),
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
                                      // decoration: BoxDecoration(
                                      //     border:
                                      //         Border.all(color: Colors.white)),
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //     border: Border.all(
                                              //         color: Colors.white)),
                                              child: Text(
                                                "Hey ${auth_state.user.name} !",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 28,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 570,
                                              width: double.infinity,
                                              // decoration: BoxDecoration(
                                              //     border: Border.all(
                                              //         color: Colors.white)),
                                              child: BlocBuilder<HomePageCubit,
                                                      HomePageState>(
                                                  builder: (context, state) {
                                                if (state is HomePageInitial)
                                                  return SpinKitCircle(
                                                    color: Colors.black,
                                                  );
                                                else if (state
                                                    is WeatherLoaded) {
                                                  return Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            geticon(state
                                                                .weather
                                                                .weatherConditionCode!),
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                              "${state.weather.areaName} || ${state.weather.weatherDescription}",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18)),
                                                          SizedBox(
                                                            height: 18,
                                                          ),
                                                          Text(
                                                              "${state.weather.temperature!.celsius!.truncate()}°C",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          80,
                                                                      color: Colors
                                                                          .white)),
                                                          SizedBox(
                                                            height: 18,
                                                          ),
                                                          Text(
                                                              "Min :: ${state.weather.tempMin}",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Max :: ${state.weather.tempMax}",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Humidity :: ${state.weather.humidity} %",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18)),
                                                          SizedBox(
                                                            height: 50,
                                                          ),
                                                          Text("5 Day Forecast",
                                                              style: GoogleFonts.montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Container(
                                                              height: 80,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white)),
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount:
                                                                          5,
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.symmetric(horizontal: 20),
                                                                          child: Icon(
                                                                              geticon(state.weather_list[i].weatherConditionCode!),
                                                                              color: Colors.white),
                                                                        );
                                                                      })),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              _launchURL(state
                                                                  .weather
                                                                  .areaName!);
                                                            },
                                                            child: Text(
                                                                "More Info",
                                                                style: GoogleFonts.montserrat(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline)),
                                                          )
                                                        ],
                                                      ));
                                                } else
                                                  return Container();
                                              }),
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

IconData geticon(int condition) {
  if (condition < 300)
    return WeatherIcons.thunderstorm;
  else if (condition < 400)
    return WeatherIcons.rain;
  else if (condition < 600)
    return WeatherIcons.day_showers;
  else if (condition < 700)
    return WeatherIcons.raindrops;
  else if (condition < 800)
    return WeatherIcons.wind_beaufort_7;
  else if (condition == 800)
    return WeatherIcons.day_sunny;
  else if (condition <= 804)
    return WeatherIcons.cloud;
  else
    return Icons.cloud;
}
