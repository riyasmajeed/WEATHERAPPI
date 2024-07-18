class WeatherForecast {
  final String day;
  final String condition;
  final String temperature;

  WeatherForecast({
    required this.day,
    required this.condition,
    required this.temperature,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      day: json['day'] != null ? json['day'].toString().substring(0, 10) : '',
      condition: json['condition'] ?? '',
      temperature: json['temperature'] ?? '',
    );
  }
}
