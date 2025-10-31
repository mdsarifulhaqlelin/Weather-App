// screens/home_screen.dart
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_application_1/services/weather_services.dart';
import 'package:flutter_application_1/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
    }
  }

  LinearGradient _buildGradient() {
    if (_weather != null) {
      final desc = _weather!.description.toLowerCase();
      if (desc.contains('rain')) {
        return const LinearGradient(
          colors: [Colors.grey, Colors.blueGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      } else if (desc.contains('clear')) {
        return const LinearGradient(
          colors: [Colors.orangeAccent, Colors.blueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      }
    }

    return const LinearGradient(
      colors: [Colors.grey, Colors.lightBlueAccent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _buildGradient(),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),

                // City input
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your City Name",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Button
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(209, 125, 155, 170),
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Loading indicator
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),

                // WeatherCard
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
