import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controll/hivedata.dart';


class WeatherListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Weather Data'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchWeatherData(),  // Fetch data from the database
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No weather data available'));
          }

          final weatherData = snapshot.data!;

          return ListView.builder(
            itemCount: weatherData.length,
            itemBuilder: (context, index) {
              final weather = weatherData[index];
              return ListTile(
                title: Text(weather['city']),
                subtitle: Text(
                  '${weather['temperature']} - ${weather['condition']} on ${weather['date']}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper().deleteWeather(weather['city']);
                    // Optionally, refresh the list
                    (context as Element).markNeedsBuild();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchWeatherData() async {
    final databaseHelper = DatabaseHelper();
    return await databaseHelper.getWeather('YourCityName');  // Replace with desired city name or modify to fetch all
  }
}
