import 'package:flutter/material.dart';

class WeatherModel extends ChangeNotifier {
  String cityName;
  double temperature;
  String mainCondition;
  double humidity;
  double windSpeed;
  double feelsLike;
  String time;

  // Constructor con valores predeterminados
  WeatherModel({
    this.cityName = "Desconocido",
    this.temperature = 0.0,
    this.mainCondition = "Desconocido",
    this.humidity = 0.0,
    this.windSpeed = 0.0,
    this.feelsLike = 0.0,
    this.time = "--:--",
  });

  // Método para actualizar el clima y notificar cambios a los widgets
  void updateWeather(WeatherModel newWeather) {
    cityName = newWeather.cityName;
    temperature = newWeather.temperature;
    mainCondition = newWeather.mainCondition;
    humidity = newWeather.humidity;
    windSpeed = newWeather.windSpeed;
    feelsLike = newWeather.feelsLike;
    time = newWeather.time;
    notifyListeners(); // Notifica a los widgets dependientes
  }

  // Convertir desde JSON (clima actual)
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      time: '', // Solo para el pronóstico diario.
    );
  }

  // Convertir desde JSON (pronóstico por horas)
  factory WeatherModel.fromJsonForecast(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: '',
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      time: json['dt_txt'], // Hora del pronóstico
    );
  }
}
