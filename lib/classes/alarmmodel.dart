import 'package:flutter/foundation.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Alarm {
  String subject;
  int hour;
  int minute;
  String timeFormat;
  Map<String, bool> selectedDays;
  bool isActive;
  String selectedTone;

  Alarm({
    required this.subject,
    required this.hour,
    required this.minute,
    required this.timeFormat,
    required this.selectedDays,
    this.isActive = false,
    required this.selectedTone,
  });

  // Convertir a JSON
  String toJson() {
    return jsonEncode({
      'subject': subject,
      'hour': hour,
      'minute': minute,
      'timeFormat': timeFormat,
      'selectedDays': selectedDays,
      'isActive': isActive,
      'selectedTone': selectedTone,
    });
  }

  // Crear un objeto Alarm desde JSON
  static Alarm fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Alarm(
      subject: json['subject'],
      hour: json['hour'],
      minute: json['minute'],
      timeFormat: json['timeFormat'],
      selectedDays: Map<String, bool>.from(json['selectedDays']),
      isActive: json['isActive'],
      selectedTone: json['selectedTone'],
    );
  }
}

class AlarmModel with ChangeNotifier {
  List<Alarm> alarms = [];

  // Método para agregar una alarma
  void addAlarm(Alarm alarm) {
    alarms.add(alarm);
    saveAlarms(); // Guardar después de agregar
    notifyListeners();
  }

  // Método para eliminar una alarma
  void removeAlarm(int index) {
    alarms.removeAt(index);
    saveAlarms(); // Guardar después de eliminar
    notifyListeners();
  }

  // Método para activar o desactivar una alarma
  void toggleAlarm(int index) {
    alarms[index].isActive = !alarms[index].isActive;
    saveAlarms(); // Guardar después de cambiar el estado
    notifyListeners();
  }

  // Guardar las alarmas en SharedPreferences
  Future<void> saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> alarmStrings = alarms.map((alarm) => alarm.toJson()).toList();
    await prefs.setStringList('alarms', alarmStrings);
  }

  // Cargar las alarmas desde SharedPreferences
  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? alarmStrings = prefs.getStringList('alarms');
    if (alarmStrings != null) {
      alarms = alarmStrings.map((string) => Alarm.fromJson(string)).toList();
      notifyListeners();
    }
  }
}
