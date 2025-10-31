// widgets/weather_card.dart
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Lottie.asset(
            weather.description.contains('rain')
                ? 'assets/animation/rain.json'
                : weather.description.contains('clear')
                    ? 'assets/animation/sunny.json'
                    : 'assets/animation/cloudy.json',
            height: 150,
            width: 150,
          ),
          Text(
            weather.cityName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            '${weather.temperature.toStringAsFixed(1)}°C',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            weather.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Humidity: ${weather.humidity}%',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                'Wind: ${weather.windspeed} m/s',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  const Text('Sunrise'),
                  Text(formatTime(weather.sunrise)),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.night_shelter_outlined, color: Colors.purple),
                  const Text('Sunset'),
                  Text(formatTime(weather.sunset)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
