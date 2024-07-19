import 'package:flutter/material.dart';
import 'package:weather/controll/sqldata.dart';

class WeatherListScreen extends StatefulWidget {
  @override
  _WeatherListScreenState createState() => _WeatherListScreenState();
}

class _WeatherListScreenState extends State<WeatherListScreen> {
  late Future<List<Map<String, dynamic>>> _weatherDataFuture;

  @override
  void initState() {
    super.initState();
    _weatherDataFuture = fetchWeatherData();
  }

  Future<List<Map<String, dynamic>>> fetchWeatherData() async {
    final databaseHelper = DatabaseHelper();
    try {
      final data = await databaseHelper.getAllWeatherData();
      if (data == null) {
        return []; // Return an empty list if data is null
      }
      return data;
    } catch (e) {
      print('Error fetching weather data: $e');
      return []; // Handle errors and return an empty list
    }
  }

  Future<void> _deleteWeather(String city) async {
    final confirmed = await _showDeleteConfirmationDialog(context);
    if (confirmed) {
      await DatabaseHelper().deleteWeather(city);
      setState(() {
        _weatherDataFuture = fetchWeatherData();  // Refresh the list
      });
    }
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this weather data?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    ) ?? false;  // Default to false if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Weather Data'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _weatherDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No weather data available'));
          }

          final weatherData = snapshot.data!;

          return ListView.builder(
            itemCount: weatherData.length,
            itemBuilder: (context, index) {
              final weather = weatherData[index];
              final city = weather['city'] ?? 'Unknown';
              final temperature = weather['temperature'] ?? 'N/A';
              final condition = weather['condition'] ?? 'No condition';
              final date = weather['date'] ?? 'No date';

              return ListTile(
                title: Text(city),
                subtitle: Text(
                  '$temperature°C - $condition on $date',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteWeather(city),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
