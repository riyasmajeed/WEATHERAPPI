import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/forcastmodel.dart';
import 'package:weather/model/model.dart';


class LocationProvider extends ChangeNotifier {
  List<WeatherForecast> forecastData = [];
  LocationData? _locationData;
  LocationData? get locationData => _locationData;

  Weather? _weatherData;
  Weather? get weatherData => _weatherData;

  List<WeatherForecast>? _forecastDataList;
  List<WeatherForecast>? get forecastDataList => _forecastDataList;

  Future<void> fetchLocation(String cityName) async {
    const apiKey = 'b39c7464ab56df782ab4652f7da5fd99';
    final apiUrl =
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        if (jsonData.isNotEmpty) {
          final location = jsonData.first;
          final double latitude = location['lat'];
          final double longitude = location['lon'];
          _locationData = LocationData(
            name: location['name'],
            lat: latitude,
            lon: longitude,
            country: location['country'],
            state: location['state'] ?? '', // Handle potential null value
          );
        print(longitude);
          notifyListeners();
          await fetchWeather(latitude, longitude); // Fetch weather after getting location
        } else {
          throw Exception('Location data not found');
        }
      } else {
        throw Exception('Failed to fetch location data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching location data: $e');
      // Handle the error appropriately
    }
  }

  Future<void> fetchWeather(double latitude, double longitude) async {
    const apiKey = 'b39c7464ab56df782ab4652f7da5fd99';
    final units = 'metric';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$units&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        _weatherData = Weather.fromJson(jsonData);

        print(response.body);

        notifyListeners();
        await fetchWeatherForecast(latitude, longitude);
      } else {
        throw Exception('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      // Handle the error appropriately
    }
  }

  Future<void> fetchWeatherForecast(double lat, double lon) async {
    final apiKey = '217697df7aeb23cbdf5313e675b8fb52';
    final apiUrl =
    
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final forecastData = json.decode(response.body);
        final List<Map<String, dynamic>> _forecastData = [];

        for (var i = 0; i < forecastData['list'].length; i += 8) {
          _forecastData.add({
            'day': DateTime.parse(forecastData['list'][i]['dt_txt'])
                .toString()
                .substring(0, 10),
            'condition': forecastData['list'][i]['weather'][0]['description'],
            'temperature':
                "${(forecastData['list'][i]['main']['temp'] - 273.15).toStringAsFixed(1)}°C",
          });
        }

        _forecastDataList = _forecastData
            .map((item) => WeatherForecast.fromJson(item))
            .toList(); // Convert to WeatherForecast objects
        notifyListeners();
      } else {
        throw Exception('Failed to load forecast');
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
      // Handle the error appropriately
    }
  }
}
