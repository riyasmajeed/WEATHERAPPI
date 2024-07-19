// import 'package:hive/hive.dart';
// import 'package:weather/model/localdata.dart';

// class WeatherAdapter {
//    final int typeId = 0;

//   Weather read(BinaryReader reader) {
//     return Weather(
//       description: reader.readString(),
//       temperature: reader.readDouble(),
//       feelsLike: reader.readDouble(),
//       minTemperature: reader.readDouble(),
//       windSpeed: reader.readDouble(),
//       humidity: reader.readInt(),
//     );
//   }

//   void write(BinaryWriter writer, Weather obj) {
//     writer.writeString(obj.description);
//     writer.writeDouble(obj.temperature);
//     writer.writeDouble(obj.feelsLike);
//     writer.writeDouble(obj.minTemperature);
//     writer.writeDouble(obj.windSpeed);
//     writer.writeInt(obj.humidity);
//   }

//   Weather fromJson(Map<String, dynamic> json) {
//     return Weather(
//       description: json['description'],
//       temperature: json['temperature'],
//       feelsLike: json['feelsLike'],
//       minTemperature: json['minTemperature'],
//       windSpeed: json['windSpeed'],
//       humidity: json['humidity'],
//     );
//   }

//   @override
//   Map<String, dynamic> toJson(Weather object) {
//     return {
//       'description': object.description,
//       'temperature': object.temperature,
//       'feelsLike': object.feelsLike,
//       'minTemperature': object.minTemperature,
//       'windSpeed': object.windSpeed,
//       'humidity': object.humidity,
//     };
//   }
// }