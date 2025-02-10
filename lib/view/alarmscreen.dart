import 'package:app_passo/classes/alarmmodel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Alarmscreen extends StatefulWidget {
  const Alarmscreen({
    super.key,
  });

  @override
  State<Alarmscreen> createState() => _AlarmscreenState();
}

class _AlarmscreenState extends State<Alarmscreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("¡Alarma Sonando!"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¡La alarma está sonando!",
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Apagar Alarma",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
