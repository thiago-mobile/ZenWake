import 'dart:async';
import 'package:app_passo/classes/alarmmodel.dart';
import 'package:app_passo/view/createalarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  bool isEditing = false;
  List<bool> selectedAlarms = [];

  @override
  void initState() {
    super.initState();
    Provider.of<AlarmModel>(context, listen: false).loadAlarms();
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
    Provider.of<AlarmModel>(context, listen: false).saveAlarms();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        selectedAlarms = List<bool>.filled(selectedAlarms.length, false);
      }
    });
  }

  void deleteSelectedAlarms(AlarmModel alarmModel) {
    setState(() {
      for (int i = selectedAlarms.length - 1; i >= 0; i--) {
        if (selectedAlarms[i]) {
          alarmModel.removeAlarm(i);
        }
      }
      selectedAlarms = List<bool>.filled(alarmModel.alarms.length, false);
    });
  }

  void sortAlarms(AlarmModel alarmModel) {
    setState(() {
      alarmModel.alarms.sort((a, b) {
        final aTime = a.hour * 60 + a.minute;
        final bTime = b.hour * 60 + b.minute;
        return aTime.compareTo(bTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final alarmModel = Provider.of<AlarmModel>(context);
    if (selectedAlarms.length != alarmModel.alarms.length) {
      selectedAlarms = List<bool>.filled(alarmModel.alarms.length, false);
    }
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff141414),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 40),
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
        actions: [
          PopupMenuButton<String>(
            color: Colors.black,
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            onSelected: (String result) {
              if (result == 'Editar') {
                toggleEditing();
              } else if (result == 'Ordenar') {
                sortAlarms(alarmModel);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Editar',
                child: Text(
                  'Editar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Ordenar',
                child: Text('Ordenar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Container(
                width: 150,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1F3C88),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  currentTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: 'JosefinSans-Light',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Alarmas Activas',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'JosefinSans-SemiBold',
                    ),
                  ),
                ),
              ),
              alarmModel.alarms.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/alarma.json', // Asegúrate de tener esta animación en tu carpeta assets
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No hay alarmas creadas. ¡Crea una nueva alarma!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: 'JosefinSans-Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: alarmModel.alarms.map((alarm) {
                        int index = alarmModel.alarms.indexOf(alarm);
                        return GestureDetector(
                          onTap: () {
                            if (isEditing) {
                              setState(() {
                                selectedAlarms[index] = !selectedAlarms[index];
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreateAlarm(existingAlarm: alarm),
                                ),
                              );
                            }
                          },
                          child: Card(
                            color: alarm.isActive
                                ? const Color(0xFF2E44AF)
                                : const Color(0xff141414),
                            elevation: 6,
                            shadowColor: const Color(0xFF2643D4),
                            margin: const EdgeInsets.all(7),
                            child: ListTile(
                              leading: isEditing
                                  ? Checkbox(
                                      value: selectedAlarms[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          selectedAlarms[index] = value!;
                                        });
                                      },
                                    )
                                  : null,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    alarm.subject,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'JosefinSans-SemiBold',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${alarm.hour}:${alarm.minute.toString().padLeft(2, '0')} ${alarm.timeFormat}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'JosefinSans-Light',
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                "${alarm.selectedDays.entries.where((entry) => entry.value).map((entry) => entry.key).join(', ')}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'JosefinSans-Regular',
                                ),
                              ),
                              trailing: isEditing
                                  ? IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          alarmModel.removeAlarm(index);
                                          selectedAlarms = List<bool>.filled(
                                              alarmModel.alarms.length, false);
                                        });
                                      },
                                    )
                                  : Switch(
                                      value: alarm.isActive,
                                      onChanged: (value) {
                                        setState(() {
                                          alarmModel.toggleAlarm(index);
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
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateAlarm()));
                },
                style: ElevatedButton.styleFrom(
                  shadowColor:
                      const Color.fromARGB(255, 208, 208, 208), // Shadow color
                  backgroundColor: const Color(0xff2643d4), // Background color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Crear Alarma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'JosefinSans-SemiBold',
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
