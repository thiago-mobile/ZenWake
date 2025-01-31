import 'dart:async';
import 'package:app_passo/classes/alarmmodel.dart';
import 'package:app_passo/view/createalarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer _timer;
  bool isSwitched = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 60), (Timer timer) {
      setState(() {
        currentTime = DateFormat('HH:mm').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alarmModel = Provider.of<AlarmModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff141414),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'ZenWake',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'JosefinSans-SemiBold',
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              ...alarmModel.alarms.map((alarm) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAlarm(existingAlarm: alarm),
                      ),
                    );
                  },
                  child: Card(
                    color: alarm.isActive
                        ? const Color(0xFF2E44AF)
                        : const Color(0xff141414),
                    elevation: 6,
                    shadowColor: const Color(0xFF2643D4),
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alarm.selectedDays.entries.where((entry) => entry.value).map((entry) => entry.key).join(', ')}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'JosefinSans-Regular',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${alarm.hour}:${alarm.minute.toString().padLeft(2, '0')} ${alarm.timeFormat}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'JosefinSans-Bold',
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        alarm.subject,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'JosefinSans-Light',
                        ),
                      ),
                      trailing: Switch(
                        value: alarm.isActive,
                        onChanged: (value) {
                          setState(() {
                            alarmModel
                                .toggleAlarm(alarmModel.alarms.indexOf(alarm));
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.blueAccent,
                        focusColor: Colors.blueGrey,
                        activeTrackColor: const Color(0xFF000000),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateAlarm()));
        },
        child: const Icon(
          Icons.add_circle_rounded,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
