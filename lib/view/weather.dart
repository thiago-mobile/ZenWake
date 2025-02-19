import 'package:app_passo/consts.dart';
import 'package:app_passo/models/weathermodel.dart';
import 'package:app_passo/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('e3d045cd24f4db577df419a77e054b54');
  WeatherModel? _weather;
  List<WeatherModel> _hourlyForecast = [];
  bool isLoading = true;

  _fetchWeather() async {
    if (!mounted)
      return; // Verifica si el widget sigue montado antes de actualizar el estado

    setState(() {
      isLoading = true; // Activa la animación de carga
    });

    var locationData = await _weatherService.getCurrentLocation();
    try {
      final forecast = await _weatherService.getHourlyWeather(
          locationData['lat'], locationData['lon']);

      if (!mounted) return; // Verifica nuevamente antes de actualizar el estado

      setState(() {
        _hourlyForecast = forecast;
        _weather = WeatherModel(
          cityName: locationData['city'],
          temperature: forecast.isNotEmpty ? forecast[0].temperature : 0.0,
          mainCondition:
              forecast.isNotEmpty ? forecast[0].mainCondition : "Unknown",
          humidity: forecast.isNotEmpty ? forecast[0].humidity : 0.0,
          windSpeed: forecast.isNotEmpty ? forecast[0].windSpeed : 0.0,
          feelsLike: forecast.isNotEmpty ? forecast[0].feelsLike : 0.0,
          time: forecast.isNotEmpty ? forecast[0].time : '',
        );
        isLoading = false;
      });
    } catch (e) {
      print(e);
      if (!mounted)
        return; // Evita actualizar el estado si el widget ya no existe
      setState(() {
        isLoading = false; // En caso de error, también oculta la animación
      });
    }
  }

  String formatTime(String time) {
    try {
      // Convierte la hora del formato "yyyy-MM-dd HH:mm:ss" (si es el formato esperado) a DateTime
      DateTime dateTime = DateTime.parse(time);
      // Usa el paquete intl para formatear la hora
      return DateFormat('hh a')
          .format(dateTime); // "hh:mm a" es el formato de 12 horas (AM/PM)
    } catch (e) {
      return time; // Si no se puede convertir, muestra el valor original
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sol.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/nube_sol.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/nube.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lluvia_chill.json';
      case 'thunderstorm':
        return 'assets/lluvia.json';
      case 'clear':
        return 'assets/sol.json';
      default:
        return 'assets/sol.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherModel>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff141414),
        title: Padding(
          padding: const EdgeInsets.only(left: 110, top: 20),
          child: Text(
            _weather?.cityName ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'JoseFinSans-Regular'),
          ),
        ),
      ),
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/clima_load.json',
                      width: 150, height: 150),
                  const SizedBox(height: 20),
                  const Text(
                    "Obteniendo datos del clima...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'JoseFinSans-Regular'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition),
                      width: 200, height: 200, fit: BoxFit.cover),
                  Text('${_weather?.temperature.round()}°C',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 37,
                          fontFamily: 'JoseFinSans-Regular')),
                  Text(_weather?.mainCondition ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'JoseFinSans-Regular')),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          const Icon(Icons.water_drop,
                              color: Colors.blue, size: 20),
                          const SizedBox(width: 5),
                          Text('${_weather?.humidity ?? "--"}%',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(width: 60),
                      Row(
                        children: [
                          const Icon(Icons.air,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 5),
                          Text('${_weather?.windSpeed ?? "--"} km/h',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(width: 45),
                      Row(
                        children: [
                          const Icon(Icons.thermostat_auto,
                              color: Colors.amber, size: 20),
                          const SizedBox(width: 5),
                          Text('${_weather?.feelsLike ?? "--"}°C',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          "Pronostico por hora",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'JoseFinSans-SemiBold',
                          ),
                        ),
                      ),
                      _buildHourlyWeatherCarousel(),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHourlyWeatherCarousel() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _hourlyForecast.length,
        itemBuilder: (context, index) {
          String weatherCondition = _hourlyForecast[index].mainCondition;
          String formattedTime = formatTime(_hourlyForecast[index].time);
          return Container(
            width: 95,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2858D0),
                  Color(0xFF1B2845),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              color: const Color.fromARGB(255, 36, 74, 170),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(getWeatherAnimation(weatherCondition),
                    width: 50, height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time,
                        color: Colors.white70, size: 16),
                    const SizedBox(width: 1),
                    Text(
                      formattedTime,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.thermostat,
                        color: Colors.orangeAccent, size: 16),
                    const SizedBox(width: 5),
                    Text('${_hourlyForecast[index].temperature.round()}°C',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
