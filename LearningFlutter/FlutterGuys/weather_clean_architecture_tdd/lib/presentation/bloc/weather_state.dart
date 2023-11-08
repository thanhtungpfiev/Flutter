import 'package:weather_clean_architecture_tdd/domain/entities/weather_entity.dart';

abstract class WeatherState {
  const WeatherState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLoaded &&
          runtimeType == other.runtimeType &&
          result == other.result;

  @override
  int get hashCode => result.hashCode;
}

class WeatherLoadFailure extends WeatherState {
  final String message;

  const WeatherLoadFailure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLoadFailure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
