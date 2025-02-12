import 'package:app_passo/classes/alarmmodel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff141414),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Lottie.asset(
              'assets/fondo.json',
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              "¡ES HOY, ES HOY!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'JosefinSans-SemiBold'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${widget.alarm?.hour.toString().padLeft(2, '0')}:${widget.alarm?.minute.toString().padLeft(2, '0')} ${widget.alarm?.timeFormat}",
              style: const TextStyle(
                color: Color(0xFF1F3C88),
                fontSize: 70,
                fontFamily: 'JosefinSans-Bold',
              ),
            ),
            const SizedBox(height: 50),
            SlideAction(
              borderRadius: 12,
              elevation: 0,
              innerColor: const Color(0xFF1F3C88),
              outerColor: const Color(0xFF2E44AF),
              submittedIcon: Icon(Icons.check),
              sliderButtonIcon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              text: 'Desliza para apagar',
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'JosefinSans-Regular'),
              onSubmit: () {
                _stopAlarm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
