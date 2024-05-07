import '../exceptions/weather_exception.dart';
import '../models/custom_error.dart';
import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import '../services/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiService weatherApiService;
  WeatherRepository({
    required this.weatherApiService,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiService.getDirectGeocoding(city);
      final Weather tempWeather =
          await weatherApiService.getWeather(directGeocoding);
      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      print('DirectGeocoding: $directGeocoding');
      print('Weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
