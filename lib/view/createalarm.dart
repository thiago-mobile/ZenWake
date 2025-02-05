import 'package:app_passo/classes/alarmmodel.dart';
import 'package:app_passo/view/sounalarm.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class CreateAlarm extends StatefulWidget {
  final Alarm? existingAlarm;
  const CreateAlarm({super.key, this.existingAlarm});
  @override
  _CreateAlarmState createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  double _currentVolume = 0.5;
  bool hayNotificacionPendiente = true;
  late int hour;
  late int minute;
  late String timeFormat;
  late Map<String, bool> _selectedDays;
  late String subject;

  @override
  void initState() {
    super.initState();
    if (widget.existingAlarm != null) {
      hour = widget.existingAlarm!.hour;
      minute = widget.existingAlarm!.minute;
      timeFormat = widget.existingAlarm!.timeFormat;
      _selectedDays = Map.from(widget.existingAlarm!.selectedDays);
      subject = widget.existingAlarm!.subject;
    } else {
      hour = 0;
      minute = 0;
      timeFormat = "AM";
      _selectedDays = {
        'Lun': false,
        'Mar': false,
        'mier': false,
        'jue': false,
        'vie': false,
        'sab': false,
        'dom': false,
      };
      subject = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff141414),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              'Create Alarm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Josefinsans-Regular',
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              // Acción al presionar el ícono
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40), // Espacio debajo de la AppBar
                  Center(
                    child: Container(
                      width: 300,
                      height: 270,
                      decoration: BoxDecoration(
                        color: const Color(0xff141414),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff2643d4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset:
                                Offset(0, 3), // Cambia la posición de la sombra
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Asunto',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontFamily: 'JosefinSans-Regular',
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  subject = value;
                                });
                              },
                              controller: TextEditingController(text: subject),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  NumberPicker(
                                    minValue: 0,
                                    maxValue: 23,
                                    zeroPad: true,
                                    infiniteLoop: true,
                                    itemWidth: 70,
                                    itemHeight: 60,
                                    value: hour,
                                    onChanged: (value) {
                                      setState(() {
                                        hour = value;
                                      });
                                    },
                                    textStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontFamily: 'JosefinSans-Regular',
                                    ),
                                    selectedTextStyle: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 30,
                                      fontFamily: 'JosefinSans-Regular',
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                            color: Colors.white,
                                          ),
                                          bottom:
                                              BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                  NumberPicker(
                                    minValue: 0,
                                    maxValue: 59,
                                    value: minute,
                                    zeroPad: true,
                                    infiniteLoop: true,
                                    itemWidth: 70,
                                    itemHeight: 60,
                                    onChanged: (value) {
                                      setState(() {
                                        minute = value;
                                      });
                                    },
                                    textStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontFamily: 'JosefinSans-Regular',
                                    ),
                                    selectedTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: 'JosefinSans-Regular',
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                            color: Colors.white,
                                          ),
                                          bottom:
                                              BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            timeFormat = "AM";
                                          });
                                        },
                                        child: Text(
                                          "AM",
                                          style: TextStyle(
                                              color: timeFormat == "AM"
                                                  ? Colors.blue
                                                  : Colors.white,
                                              fontSize: 25,
                                              fontFamily:
                                                  'JosefinSans-Regular'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            timeFormat = "PM";
                                          });
                                        },
                                        child: Text(
                                          "PM",
                                          style: TextStyle(
                                              color: timeFormat == "PM"
                                                  ? Colors.blue
                                                  : Colors.white,
                                              fontSize: 25,
                                              fontFamily:
                                                  'JosefinSans-Regular'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _selectedDays.keys.map((day) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDays[day] = !_selectedDays[day]!;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _selectedDays[day] == true
                                ? const Color(0xff2643d4)
                                : const Color(0xff2E313A),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Color(0xff2643d4),
                    thickness: 2,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 280),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sonido',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SoundAlarm()),
                                );
                              },
                              child: const Text(
                                'Default',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontFamily: 'JosefinSans-Light',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xff2643d4),
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Volumen',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'JosefinSans-SemiBold',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: _currentVolume,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          onChanged: (double value) {
                            setState(() {
                              _currentVolume = value;
                            });
                          },
                          activeColor: const Color(0xff2643d4),
                          inactiveColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xff2643d4),
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2643d4),
                      fixedSize: const Size(70, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      final newAlarm = Alarm(
                        subject: subject,
                        hour: hour,
                        minute: minute,
                        timeFormat: timeFormat,
                        selectedDays: _selectedDays,
                      );
                      if (widget.existingAlarm != null) {
                        // Update existing alarm
                        final alarmModel =
                            Provider.of<AlarmModel>(context, listen: false);
                        final index =
                            alarmModel.alarms.indexOf(widget.existingAlarm!);
                        alarmModel.alarms[index] = newAlarm;
                        alarmModel.notifyListeners();
                      } else {
                        // Add new alarm
                        Provider.of<AlarmModel>(context, listen: false)
                            .addAlarm(newAlarm);
                      }
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
