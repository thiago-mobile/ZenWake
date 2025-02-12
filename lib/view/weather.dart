import 'package:app_passo/consts.dart';
import 'package:app_passo/models/weathermodel.dart';
import 'package:app_passo/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('e3d045cd24f4db577df419a77e054b54');
  WeatherModel? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather; // No necesitas hacer casting
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141414),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "cargando ciudad..",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '${_weather?.temperature.round()}°c',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
