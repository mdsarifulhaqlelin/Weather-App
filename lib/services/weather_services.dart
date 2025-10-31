// services/weather_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherServices {
  final String apiKey = 'c7a65e81a6ccfabc6ce7245877f26098';

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
