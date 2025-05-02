import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SleepModel with ChangeNotifier {
  List<SleepRecord> _records = [];

  List<SleepRecord> get records => _records;

  void addRecord(SleepRecord record) async {
    _records.add(record);
    await saveRecords();
    notifyListeners();
  }

  Future<void> saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = _records.map((e) => e.toJson()).toList();
    await prefs.setStringList('sleep_records', jsonList);
  }

  Future<void> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('sleep_records');
    if (jsonList != null) {
      _records = jsonList.map((e) => SleepRecord.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
class SleepRecord {
  final DateTime sleepTime;
  final DateTime wakeUpTime;
  final int challengeErrors;

  SleepRecord({
    required this.sleepTime,
    required this.wakeUpTime,
    this.challengeErrors = 0,
  });

  double get hoursSlept => wakeUpTime.difference(sleepTime).inMinutes / 60;

  String toJson() {
    return jsonEncode({
      'sleepTime': sleepTime.toIso8601String(),
      'wakeUpTime': wakeUpTime.toIso8601String(),
      'challengeErrors': challengeErrors,
    });
  }

  static SleepRecord fromJson(String jsonString) {
    final json = jsonDecode(jsonString);
    return SleepRecord(
      sleepTime: DateTime.parse(json['sleepTime']),
      wakeUpTime: DateTime.parse(json['wakeUpTime']),
      challengeErrors: json['challengeErrors'] ?? 0,
    );
  }
}

