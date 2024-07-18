class LocationData {
  String name;
  Map<String, String>? localNames;
  double lat;
  double lon;
  String country;
  String state;
  

  LocationData({
    required this.name,
    this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });
}

class Weather {
  final String? description;
  final double temperature;
  final double windSpeed;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;
  final double? feelsLike; // Nullable property for feels like temperature
  

  Weather({
    required this.temperature,
    required this.windSpeed,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    this.description,
    this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
     description: json['weather'][0]['description'] as String?,
    temperature: (json['main']['temp'] as num).toDouble(),
    windSpeed: (json['wind']['speed'] as num).toDouble(),
    maxTemperature: (json['main']['temp_max'] as num).toDouble(),
    minTemperature: (json['main']['temp_min'] as num).toDouble(),
    humidity: (json['main']['humidity'] as num).toDouble(),
    feelsLike: (json['main']['feels_like'] as num).toDouble(),
    );
  }
}
