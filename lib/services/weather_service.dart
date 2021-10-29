import 'package:weather/weather.dart';

class WeatherService {
  WeatherFactory wf = new WeatherFactory("e22fc4152d0f53f723f548a7c99f504f");

  Future<Weather> getweather(String city) async {
    Weather w = await wf.currentWeatherByCityName(city);
    return w;
  }

  Future<List<Weather>> getfivedayforecast(String city) async {
    List<Weather> forecast = await wf.fiveDayForecastByCityName(city);
    return forecast;
  }
}
