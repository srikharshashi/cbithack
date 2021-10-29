part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class WeatherLoaded extends HomePageState {
  Weather weather;
  List<Weather> weather_list;
  WeatherLoaded({
    required this.weather,
    required this.weather_list,
  });
}
