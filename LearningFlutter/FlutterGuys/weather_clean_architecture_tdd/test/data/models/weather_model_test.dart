import "dart:convert";

import "package:flutter_test/flutter_test.dart";
import "package:weather_clean_architecture_tdd/data/models/weather_model.dart";
import "package:weather_clean_architecture_tdd/domain/entities/weather_entity.dart";

import "../../helpers/json_reader.dart";

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // arrange
    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        }
      ],
      'main': {
        'temp': 292.87,
        'pressure': 1012,
        'humidity': 70,
      },
      'name': 'New York',
    };

    // act
    final result = testWeatherModel.toJson();

    // assert
    expect(result, equals(expectedJsonMap));
  });

  test('should return a entity containing proper data', () async {
    // arrange
    const expectedEntity = WeatherEntity(
      cityName: 'New York',
      main: 'Clear',
      description: 'clear sky',
      iconCode: '01n',
      temperature: 292.87,
      pressure: 1012,
      humidity: 70,
    );

    // act
    final result = testWeatherModel.toEntity();

    // assert
    expect(result, equals(expectedEntity));
  });
}
