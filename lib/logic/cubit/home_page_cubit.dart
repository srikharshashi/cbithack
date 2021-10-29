import 'package:bloc/bloc.dart';
import 'package:bloc_custom_firebase/services/location_service.dart';
import 'package:bloc_custom_firebase/services/weather_service.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial()) {
    getlocation();
  }

  void getlocation() async {
    var loc_list = await LocationService().getlocation();
    String city = loc_list[0].locality.toString();
    Weather w = await WeatherService().getweather(city);

    List<Weather> forecast = await WeatherService().getfivedayforecast(city);
    emit(WeatherLoaded(weather: w, weather_list: forecast));
    print(w);
    print(forecast);
  }
}
