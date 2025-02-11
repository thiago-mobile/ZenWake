import 'package:app_passo/classes/alarmmodel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Alarmscreen extends StatefulWidget {
  final Alarm? alarm;
  const Alarmscreen({Key? key, required this.alarm}) : super(key: key);

  @override
  State<Alarmscreen> createState() => _AlarmscreenState();
}

class _AlarmscreenState extends State<Alarmscreen> {
  late AudioPlayer _audioPlayer;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Reproducir el tono de la alarma
    _playAlarmTone();
  }

  void _playAlarmTone() async {
    String soundPath =
        '${widget.alarm?.selectedTone}.mp3'; // No agregar 'assets/' aquí
    await _audioPlayer.setSource(AssetSource(soundPath));
    _audioPlayer.setVolume(1.0);
    _audioPlayer.resume();
  }

  void _stopAlarm() {
    _audioPlayer.stop();
    Navigator.pop(context); // Volver a la pantalla principal
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

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
              onPressed: () {
                _stopAlarm();
              },
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
