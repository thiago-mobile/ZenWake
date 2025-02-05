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
  late TextEditingController _subjectController;

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
    _subjectController = TextEditingController(text: subject);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 48,
                                    fontFamily: 'JosefinSans-Regular',
                                  ),
                                  selectedTextStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 55,
                                    fontFamily: 'JosefinSans-Regular',
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
                                    fontSize: 48,
                                    fontFamily: 'JosefinSans-Regular',
                                  ),
                                  selectedTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontFamily: 'JosefinSans-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        hintText: 'Asunto',
                        focusColor: Colors.blue,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          decorationColor: Colors.blue,
                          fontSize: 20,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue, // Color azul al enfocar
                          ),
                        ),
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'JosefinSans-Regular',
                      ),
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        setState(() {
                          subject = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                          width: 40,
                          height: 40,
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
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 280),
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
                                  color: Colors.blue,
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
                    color: Colors.grey,
                    thickness: 1,
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
