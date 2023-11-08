abstract class WeatherEvent {
  const WeatherEvent();
}

class OnCityChanged extends WeatherEvent {
  final String cityName;

  const OnCityChanged(this.cityName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnCityChanged &&
          runtimeType == other.runtimeType &&
          cityName == other.cityName;

  @override
  int get hashCode => cityName.hashCode;
}
