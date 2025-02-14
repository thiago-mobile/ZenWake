class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double humidity;
  final double windSpeed;
  final double feelsLike;
  final String time; // Para mostrar la hora de la predicción.

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.time,
  });

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

  // Crear un constructor para el pronóstico horario.
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
