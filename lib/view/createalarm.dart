import 'package:app_passo/Widgets/waveclipper.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateAlarm extends StatefulWidget {
  const CreateAlarm({super.key});
  @override
  _CreateAlarmState createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";
  // var _selectday = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff2643d4),
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
      ),
      body: Stack(
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
                        offset: Offset(0, 3), // Cambia la posición de la sombra
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
                            fontSize: 21,
                            fontFamily: 'JosefinSans-Regular',
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      bottom: BorderSide(color: Colors.white)),
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
                                      bottom: BorderSide(color: Colors.white)),
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
                                            fontFamily: 'JosefinSans-Regular'),
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
                                            fontFamily: 'JosefinSans-Regular'),
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
                children: [
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Lun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'mar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'mie',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'jue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'vie',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'sab',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff2643d4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'dom',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'JosefinSans-Regular',
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
