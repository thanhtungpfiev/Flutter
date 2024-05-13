import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'c8b6969b85074230855140212232805';
const weatherURL = 'https://api.weatherapi.com/v1/current.json';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location);

    final queryParams = {
      'key': apiKey,
      'q': '${location.latitude}, ${location.longitude}',
      'aqi': 'no',
    };
    final uri = Uri.parse(weatherURL).replace(queryParameters: queryParams);
    var weatherData = await NetworkHelper(uri: uri).getData();
    return weatherData;
  }

  Future getCityWeatherData(String cityName) async {
    final queryParams = {
      'key': apiKey,
      'q': cityName,
      'aqi': 'no',
    };
    final uri = Uri.parse(weatherURL).replace(queryParameters: queryParams);
    var weatherData = await NetworkHelper(uri: uri).getData();
    return weatherData;
  }
}
