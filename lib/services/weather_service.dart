import 'dart:convert';

import 'package:app_passo/models/weathermodel.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/forecast';

  final String apikey;

  WeatherService(this.apikey);

  Future<List<WeatherModel>> getHourlyWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?lat=$lat&lon=$lon&appid=$apikey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<WeatherModel> hourlyForecast = [];
      for (var item in data['list']) {
        hourlyForecast.add(WeatherModel.fromJsonForecast(item));
      }

      return hourlyForecast;
    } else {
      throw Exception('Error al cargar el clima');
    }
  }

  Future<Map<String, dynamic>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);

    String? city = placemarks[0].locality;
    print("Lat: ${position.latitude}, Lon: ${position.longitude}");
    return {
      'city': city ?? "Ubicación desconocida",
      'lat': position.latitude,
      'lon': position.longitude,
    };
  }
}
