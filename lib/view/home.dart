// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather/controll/api.dart';

// import 'package:intl/intl.dart';
// import 'package:weather/controll/hivedata.dart';


// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final TextEditingController _cityController = TextEditingController();

//   @override
//   void dispose() {
//     _cityController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final locationProvider = Provider.of<LocationProvider>(context);
//     final weatherData = locationProvider.weatherData;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: SafeArea(
//         child: Scaffold(
//           backgroundColor: Color.fromARGB(45, 0, 0, 0),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _cityController,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       labelText: 'search',
//                       labelStyle: TextStyle(fontSize: 20),
//                       hintText: 'Enter city name',
//                       prefixIcon: Icon(
//                         Icons.location_on_sharp,
//                         size: 30,
//                       ),
//                       suffixIcon: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.search, size: 30),
//                             onPressed: () {
//                               final cityName = _cityController.text;
//                               if (cityName.isNotEmpty) {
//                                 locationProvider.fetchLocation(cityName);
//                               }
//                             },
//                           ),
//                           IconButton(
//                             onPressed: () {
                               
//                             },
//                             icon: Icon(Icons.more_vert_sharp, size: 30),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 250,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(30)),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFF3366FF),
//                           Color(0xFF00CCFF),
//                         ],
//                         begin: FractionalOffset(0.0, 0.0),
//                         end: FractionalOffset(1.0, 0.0),
//                         stops: [0.0, 1.0],
//                         tileMode: TileMode.clamp,
//                       ),
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: 20,
//                           left: 20,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Today ${DateFormat('dd MMM').format(DateTime.now())}',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 weatherData?.description ?? 'N/A',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 5,
//                           left: 20,
//                           child: Row(
//                             children: [
//                               Text(
//                                 '${weatherData?.temperature.toInt() ?? 0}',
//                                 style: TextStyle(
//                                   fontSize: 80,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(width: 75),
//                               Text(
//                                 '${weatherData?.feelsLike?.toInt() ?? 0}°/',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 '${weatherData?.minTemperature.toInt() ?? 0}°',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 65,
//                           left: 115,
//                           child: Container(
//                             child: Text(
//                               '°C',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: 35,
//                           bottom: 25,
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               color: Color.fromARGB(24, 255, 255, 255),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 print("object");
//                               },
//                               child: Icon(Icons.settings_backup_restore),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     width: double.infinity,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(30)),
//                       color: Color.fromARGB(23, 255, 255, 255),
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: 20,
//                           left: 15,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Feels like',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color.fromARGB(255, 247, 244, 244),
//                                 ),
//                               ),
//                               TextButton.icon(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.thermostat,
//                                   color: Colors.white,
//                                 ),
//                                 label: Text(
//                                   '${weatherData?.feelsLike?.toString() ?? "0"}°C',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 20,
//                           right: 15,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 weatherData?.description ?? 'N/A',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color.fromARGB(255, 247, 244, 244),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         height: 95,
//                         width: 180,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           color: Color.fromARGB(23, 255, 255, 255),
//                         ),
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               top: 20,
//                               left: 15,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Wind speed',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Color.fromARGB(255, 247, 244, 244),
//                                     ),
//                                   ),
//                                   TextButton.icon(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.wind_power,
//                                       color: Colors.white,
//                                     ),
//                                     label: Text(
//                                       '${weatherData?.windSpeed.toString() ?? "0"} km/h',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 180,
//                         height: 95,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           color: Color.fromARGB(23, 255, 255, 255),
//                         ),
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               top: 20,
//                               left: 15,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Humidity',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Color.fromARGB(255, 247, 244, 244),
//                                     ),
//                                   ),
//                                   TextButton.icon(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.water_drop,
//                                       color: Colors.white,
//                                     ),
//                                     label: Text(
//                                       '${weatherData?.humidity.toString() ?? "0"}%',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     height: 390,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(30)),
//                       color: Color.fromARGB(23, 255, 255, 255),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: TextButton.icon(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.date_range_sharp,
//                               color: Colors.white,
//                             ),
//                             label: Text(
//                               '5-day forecast',
//                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                             child: ListView.builder(
//                             itemCount: locationProvider.forecastDataList?.length ?? 0,
//                             itemBuilder: (context, index) {
//                               final forecast = locationProvider.forecastDataList?[index];
//                               final date = DateFormat('yyyy-MM-dd').parse(forecast!.day);
//                               final dayName = DateFormat('EEEE').format(date);

//                               return Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         TextButton.icon(
//                                           onPressed: () {},
//                                           icon: Icon(
//                                             Icons.sunny,
//                                             color: Colors.white,
//                                           ),
//                                           label: Text(
//                                             dayName,
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                         Text('${forecast.condition}'),
//                                         SizedBox(width: 75),
//                                         Text('${forecast.temperature}'),
//                                       ],
//                                     ),
//                                   ),
//                                   Divider(),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controll/api.dart';
import 'package:intl/intl.dart';
import 'package:weather/view/storedata.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cityController = TextEditingController();
  List<String> _suggestions = [];
  late LocationProvider locationProvider;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final recentSearches = await locationProvider.getRecentSearches();
    setState(() {
      _suggestions = recentSearches;
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    final weatherData = locationProvider.weatherData;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(45, 0, 0, 0),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Search',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Enter city name',
                      prefixIcon: Icon(
                        Icons.location_on_sharp,
                        size: 30,
                      ),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.search, size: 30),
                            onPressed: () {
                              final cityName = _cityController.text;
                              if (cityName.isNotEmpty) {
                                locationProvider.fetchLocation(cityName);
                                locationProvider.saveSearchQuery(cityName); // Save the search query
                                _loadRecentSearches(); // Reload suggestions
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => WeatherListScreen()),
);
                            },
                            icon: Icon(Icons.more_vert_sharp, size: 30),
                          ),
                        ],
                      ),
                    ),
                    onChanged: (text) async {
                      final recentSearches = await locationProvider.getRecentSearches();
                      setState(() {
                        _suggestions = recentSearches
                            .where((search) => search.toLowerCase().contains(text.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  if (_suggestions.isNotEmpty)
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = _suggestions[index];
                          return ListTile(
                            title: Text(suggestion),
                            onTap: () {
                              _cityController.text = suggestion;
                              locationProvider.fetchLocation(suggestion);
                              locationProvider.saveSearchQuery(suggestion); // Save the search query
                              setState(() {
                                _suggestions = [];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  // Weather display code...
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3366FF),
                          Color(0xFF00CCFF),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today ${DateFormat('dd MMM').format(DateTime.now())}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                weatherData?.description ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 20,
                          child: Row(
                            children: [
                              Text(
                                '${weatherData?.temperature.toInt() ?? 0}',
                                style: TextStyle(
                                  fontSize: 80,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 75),
                              Text(
                                '${weatherData?.feelsLike?.toInt() ?? 0}°/',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${weatherData?.minTemperature.toInt() ?? 0}°',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 65,
                          left: 115,
                          child: Container(
                            child: Text(
                              '°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 35,
                          bottom: 25,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(24, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: InkWell(
                              onTap: ()async {
                                  final cityName = locationProvider.locationData?.name ?? '';
                                  if (cityName.isNotEmpty) {
                                    await locationProvider.deleteWeatherFromDatabase(cityName);
                                    await locationProvider.clearRecentSearches(); // Clear recent searches
                                  }
                                },
                              child: Icon(Icons.settings_backup_restore),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(23, 255, 255, 255),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Feels like',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 247, 244, 244),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.thermostat,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  '${weatherData?.feelsLike?.toString() ?? "0"}°C',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                weatherData?.description ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 247, 244, 244),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 95,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromARGB(23, 255, 255, 255),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Wind speed',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 247, 244, 244),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.wind_power,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      '${weatherData?.windSpeed.toString() ?? "0"} km/h',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromARGB(23, 255, 255, 255),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Humidity',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 247, 244, 244),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.water_drop,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      '${weatherData?.humidity.toString() ?? "0"}%',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 390,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(23, 255, 255, 255),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.date_range_sharp,
                              color: Colors.white,
                            ),
                            label: Text(
                              '5-day forecast',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                            itemCount: locationProvider.forecastDataList?.length ?? 0,
                            itemBuilder: (context, index) {
                              final forecast = locationProvider.forecastDataList?[index];
                              final date = DateFormat('yyyy-MM-dd').parse(forecast!.day);
                              final dayName = DateFormat('EEEE').format(date);

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            dayName,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Text('${forecast.condition}'),
                                        SizedBox(width: 75),
                                        Text('${forecast.temperature}'),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
