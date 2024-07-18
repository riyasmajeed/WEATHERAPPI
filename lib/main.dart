import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controll/api.dart';
import 'package:weather/view/home.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
      return MultiProvider(
        providers:[ 
          // ChangeNotifierProvider(
          //  create: (context) => WeatherProvider(),
          // ),
            ChangeNotifierProvider(create: (context) => LocationProvider(),
        )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
         theme: ThemeData.dark(),
          home: SafeArea(
            child: Scaffold(
            body: Home(),
            
          
            
            ),
          ),
        ),
            );
      
  }
}