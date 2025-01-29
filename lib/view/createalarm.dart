import 'package:app_passo/Widgets/waveclipper.dart';
import 'package:app_passo/view/sounalarm.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateAlarm extends StatefulWidget {
  const CreateAlarm({super.key});
  @override
  _CreateAlarmState createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  double _currentVolume = 0.5;
  bool hayNotificacionPendiente = true;
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";
  final Map<String, bool> _selectedDays = {
    'Lun': false,
    'Mar': false,
    'mier': false,
    'jue': false,
    'vie': false,
    'sab': false,
    'dom': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff2643d4),
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
          padding: EdgeInsets.only(top: 35),
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
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 100.0,
                  color: const Color(0xff2643d4),
                ),
              ),
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
                            const TextField(
                              decoration: InputDecoration(
                                hintText: 'Asunto',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontFamily: 'JosefinSans-Regular',
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  NumberPicker(
                                    minValue: 0,
                                    maxValue: 12,
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
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: timeFormat == "AM"
                                                  ? const Color(0xff2643d4)
                                                  : const Color(0xff141414),
                                              border: Border.all(
                                                color: timeFormat == "AM"
                                                    ? const Color(0xff2643d4)
                                                    : const Color(0xff141414),
                                              )),
                                          child: const Text(
                                            "AM",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontFamily:
                                                    'JosefinSans-Regular'),
                                          ),
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
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: timeFormat == "PM"
                                                  ? const Color(0xff2643d4)
                                                  : const Color(0xff141414),
                                              border: Border.all(
                                                color: timeFormat == "PM"
                                                    ? const Color(0xff2643d4)
                                                    : const Color(0xff141414),
                                              )),
                                          child: const Text(
                                            "PM",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontFamily:
                                                    'JosefinSans-Regular'),
                                          ),
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
                          width: 47,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _selectedDays[day] == true
                                ? const Color(0xff2643d4)
                                : const Color(0xff2E313A),
                            borderRadius: BorderRadius.circular(10),
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
                  SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Color(0xff2643d4),
                    thickness: 2,
                  ),
                  Stack(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sonido',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'JosefinSans-SemiBold',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 190,
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
                                fontSize: 20,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                          ),
                          if (hayNotificacionPendiente)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 25,
                                left:
                                    0, // Ajusta el valor para subir el punto rojo
                              ),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xff2643d4),
                    thickness: 2,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
