import 'package:flutter/foundation.dart';

class Alarm {
  String subject;
  int hour;
  int minute;
  String timeFormat;
  Map<String, bool> selectedDays;
  bool isActive;

  Alarm(
      {required this.subject,
      required this.hour,
      required this.minute,
      required this.timeFormat,
      required this.selectedDays,
      this.isActive = false});
}

class AlarmModel with ChangeNotifier {
  List<Alarm> alarms = [];

  void addAlarm(Alarm alarm) {
    alarms.add(alarm);
    notifyListeners();
  }

  void removeAlarm(int index) {
    alarms.removeAt(index);
    notifyListeners();
  }

  void toggleAlarm(int index) {
    alarms[index].isActive = !alarms[index].isActive;
    notifyListeners();
  }
}
