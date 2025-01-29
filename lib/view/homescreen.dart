import 'dart:async';
import 'package:app_passo/Widgets/waveclipper.dart';
import 'package:app_passo/view/createAlarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer _timer;
  bool isSwitched = false;

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
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff2643d4),
        title: const Padding(
          padding: EdgeInsets.only(top: 35),
          child: Center(
            child: Text(
              'ZenWake',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'JosefinSans-SemiBold',
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 80.0,
                color: Color(0xff2643d4),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          currentTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontFamily: 'JosefinSans-Light',
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                          indent: 40,
                          endIndent: 40,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  color: const Color(0xFF2E44AF),
                  elevation: 6,
                  shadowColor:
                      const Color(0xFF2643D4), // Añade sombra a la tarjeta
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      currentTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'JosefinSans-SemiBold',
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('EEEE')
                          .format(DateTime.now()), // Muestra el día
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'JosefinSans-Light',
                      ),
                    ),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: Colors.blueAccent,
                      focusColor: Colors.blueGrey,
                      activeTrackColor: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateAlarm()));
        },
        child: Image.asset('assets/agregarAlarma.png', width: 50, height: 50),
      ),
    );
  }
}
