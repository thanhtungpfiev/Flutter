class WeatherEntity {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

//<editor-fold desc="Data Methods">
  const WeatherEntity({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherEntity &&
          runtimeType == other.runtimeType &&
          cityName == other.cityName &&
          main == other.main &&
          description == other.description &&
          iconCode == other.iconCode &&
          temperature == other.temperature &&
          pressure == other.pressure &&
          humidity == other.humidity);

  @override
  int get hashCode =>
      cityName.hashCode ^
      main.hashCode ^
      description.hashCode ^
      iconCode.hashCode ^
      temperature.hashCode ^
      pressure.hashCode ^
      humidity.hashCode;

  @override
  String toString() {
    return 'WeatherEntity{ cityName: $cityName, main: $main, description: $description, iconCode: $iconCode, temperature: $temperature, pressure: $pressure, humidity: $humidity,}';
  }

  WeatherEntity copyWith({
    String? cityName,
    String? main,
    String? description,
    String? iconCode,
    double? temperature,
    int? pressure,
    int? humidity,
  }) {
    return WeatherEntity(
      cityName: cityName ?? this.cityName,
      main: main ?? this.main,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      temperature: temperature ?? this.temperature,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'main': main,
      'description': description,
      'iconCode': iconCode,
      'temperature': temperature,
      'pressure': pressure,
      'humidity': humidity,
    };
  }

  factory WeatherEntity.fromMap(Map<String, dynamic> map) {
    return WeatherEntity(
      cityName: map['cityName'] as String,
      main: map['main'] as String,
      description: map['description'] as String,
      iconCode: map['iconCode'] as String,
      temperature: map['temperature'] as double,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
    );
  }

//</editor-fold>
}
