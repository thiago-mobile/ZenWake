import 'dart:math';
import 'package:app_passo/models/alarmmodel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:vibration/vibration.dart';

class Alarmscreen extends StatefulWidget {
  final Alarm? alarm;
  const Alarmscreen({Key? key, required this.alarm}) : super(key: key);

  @override
  State<Alarmscreen> createState() => _AlarmscreenState();
}

class _AlarmscreenState extends State<Alarmscreen> {
  late AudioPlayer _audioPlayer;
  bool _challengeCompleted = false; // Variable para controlar el desafío

  // Datos de ejemplo (deberías reemplazarlos con tus imágenes y datos reales)
  final List<Map<String, String>> _flags = [
    {"country": "Argentina", "image": "assets/flags/argentina.png"},
    {"country": "Bolivia", "image": "assets/flags/bolivia.png"},
    {"country": "Brasil", "image": "assets/flags/brasil.png"},
    {"country": "Chile", "image": "assets/flags/chile.png"},
    {"country": "Colombia", "image": "assets/flags/colombia.png"},
    {"country": "Costa Rica", "image": "assets/flags/costa_rica.png"},
    {"country": "Cuba", "image": "assets/flags/cuba.png"},
    {"country": "Ecuador", "image": "assets/flags/ecuador.png"},
    {"country": "España", "image": "assets/flags/espana.png"},
    {"country": "Guatemala", "image": "assets/flags/guatemala.png"},
    {"country": "Honduras", "image": "assets/flags/honduras.png"},
    {"country": "México", "image": "assets/flags/mexico.png"},
    {"country": "Nicaragua", "image": "assets/flags/nicaragua.png"},
    {"country": "Paraguay", "image": "assets/flags/paraguay.png"},
    {"country": "Perú", "image": "assets/flags/peru.png"},
    {"country": "Puerto Rico", "image": "assets/flags/puerto_rico.png"},
    {"country": "El Salvador", "image": "assets/flags/salvador.png"},
    {"country": "Uruguay", "image": "assets/flags/uruguay.png"},
    {"country": "Venezuela", "image": "assets/flags/venezuela.png"},
    {"country": "Estados Unidos", "image": "assets/flags/estados_unidos.png"},
    {"country": "Canadá", "image": "assets/flags/canada.png"},
    {"country": "Inglaterra", "image": "assets/flags/inglaterra.png"},
    {"country": "Italia", "image": "assets/flags/italia.png"},
    {"country": "Alemania", "image": "assets/flags/alemania.png"},
    {"country": "Francia", "image": "assets/flags/francia.png"},
    {"country": "Portugal", "image": "assets/flags/portugal.png"},
    {"country": "Irlanda", "image": "assets/flags/irlanda.png"},
    {"country": "Escocia", "image": "assets/flags/escocia.png"},
    {"country": "Afganistán", "image": "assets/flags/afghanistan.png"},
    {"country": "Albania", "image": "assets/flags/albania.png"},
    {"country": "Andorra", "image": "assets/flags/andorra.png"},
    {"country": "Angola", "image": "assets/flags/angola.png"},
    {"country": "Arabia Saudita", "image": "assets/flags/arabia_saudita.png"},
    {"country": "Argelia", "image": "assets/flags/argelia.png"},
    {"country": "Armenia", "image": "assets/flags/armenia.png"},
    {"country": "Australia", "image": "assets/flags/australia.png"},
    {"country": "Austria", "image": "assets/flags/austria.png"},
    {"country": "Bangladesh", "image": "assets/flags/bangladesh.png"},
    {"country": "Bélgica", "image": "assets/flags/belgica.png"},
    {"country": "Gales", "image": "assets/flags/gales.png"},
    {"country": "Bosnia", "image": "assets/flags/bosnia.png"},
    {"country": "Suiza", "image": "assets/flags/suiza.png"},
    {"country": "Taiwán", "image": "assets/flags/taiwan.png"},
    {"country": "Vietnam", "image": "assets/flags/vietnam.png"},
    {"country": "Grecia", "image": "assets/flags/grecia.png"},
    {"country": "Senegal", "image": "assets/flags/senegal.png"},
    {"country": "Serbia", "image": "assets/flags/serbia.png"},
    {"country": "Estonia", "image": "assets/flags/estonia.png"},
    {"country": "Finlandia", "image": "assets/flags/finlandia.png"},
    {"country": "Sudán", "image": "assets/flags/sudan.png"},
    {"country": "Samoa", "image": "assets/flags/samoa.png"},
    {"country": "República Checa", "image": "assets/flags/republica_cheka.png"},
    {"country": "Indonesia", "image": "assets/flags/indonesia.png"},
    {"country": "Irán", "image": "assets/flags/iran.png"},
    {"country": "Islandia", "image": "assets/flags/islandia.png"},
    {"country": "Japón", "image": "assets/flags/japon.png"},
    {"country": "Irak", "image": "assets/flags/iraq.png"},
    {"country": "Nueva Zelanda", "image": "assets/flags/nueva_zelanda.png"},
    {"country": "Rumania", "image": "assets/flags/rumania.png"},
    {"country": "Croacia", "image": "assets/flags/croacia.png"},
    {"country": "República Dominicana", "image": "assets/flags/dominicana.png"},
    {"country": "Eslovaquia", "image": "assets/flags/slovakia.png"},
    {"country": "Suecia", "image": "assets/flags/suecia.png"},
    {"country": "Luxemburgo", "image": "assets/flags/luxemburgo.png"},
    {"country": "Malta", "image": "assets/flags/malta.png"},
    {"country": "Malí", "image": "assets/flags/mali.png"},
    {"country": "Marruecos", "image": "assets/flags/marruecos.png"},
    {"country": "Pakistán", "image": "assets/flags/pakistan.png"},
    {"country": "Países Bajos", "image": "assets/flags/netherlands.png"},
    {"country": "Panamá", "image": "assets/flags/panama.png"},
    {"country": "Rusia", "image": "assets/flags/rusia.png"},
    {"country": "Sudáfrica", "image": "assets/flags/sudafrica.png"},
    {"country": "Tanzania", "image": "assets/flags/tanzania.png"},
    {"country": "Turquía", "image": "assets/flags/turquia.png"},
    {"country": "Ucrania", "image": "assets/flags/ucrania.png"},
    {"country": "Uganda", "image": "assets/flags/uganda.png"},
    {"country": "Yemen", "image": "assets/flags/yemen.png"},
  ];

  late Map<String, String> _correctFlag;
  late List<Map<String, String>> _options;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAlarmTone();
    _generateFlagChallenge();
  }

  void _playAlarmTone() async {
    if (widget.alarm?.isVibrationEnabled ?? false) {
      bool? canVibrate = await Vibration.hasVibrator();
      if (canVibrate == true) {
        Vibration.vibrate(pattern: [200, 1000, 200, 1000]);
      }
    }
    String soundPath = '${widget.alarm?.selectedTone}.mp3';
    await _audioPlayer.setSource(AssetSource(soundPath));
    _audioPlayer.setVolume(1.0);
    _audioPlayer.resume();
  }

  void _generateFlagChallenge() {
    final random = Random();
    _correctFlag = _flags[random.nextInt(_flags.length)];

    // Mezclar opciones aleatorias con la correcta
    List<Map<String, String>> shuffledFlags = List.from(_flags)..shuffle();
    _options = shuffledFlags.take(3).toList();

    // Asegurar que la correcta está incluida
    if (!_options.contains(_correctFlag)) {
      _options[random.nextInt(3)] = _correctFlag;
    }
  }

  void _checkAnswer(String country) {
    if (country == _correctFlag["country"]) {
      setState(() {
        _challengeCompleted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Respuesta incorrecta. Intenta otra vez.")),
      );
    }
  }

  Future<void> _stopAlarm() async {
    await _audioPlayer.stop();
    Vibration.cancel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0000),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff0000),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Lottie.asset('assets/fondo.json', width: 280, height: 280),
            const SizedBox(height: 30),
            const Text(
              "adivina la bandera para apagarme!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'JosefinSans-Bold',
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "${widget.alarm?.hour.toString().padLeft(2, '0')}:${widget.alarm?.minute.toString().padLeft(2, '0')} ${widget.alarm?.timeFormat}",
              style: const TextStyle(
                color: Color(0xFF1F3C88),
                fontSize: 70,
                fontFamily: 'JosefinSans-Bold',
              ),
            ),
            const SizedBox(height: 50),

            // Desafío de la bandera
            if (!_challengeCompleted) ...[
              const Text(
                "Selecciona la bandera de:",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                _correctFlag["country"]!,
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: _options.map((flag) {
                          return GestureDetector(
                            onTap: () => _checkAnswer(flag["country"]!),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 120,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  flag["image"]!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ],

            // Botón deslizable (se activa solo si se completó el desafío)
            if (_challengeCompleted)
              SlideAction(
                borderRadius: 12,
                elevation: 0,
                innerColor: const Color(0xFF1F3C88),
                outerColor: const Color(0xFF2E44AF),
                submittedIcon: const Icon(Icons.check),
                sliderButtonIcon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                text: 'Desliza para apagar',
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'JosefinSans-Regular'),
                onSubmit: _stopAlarm,
              ),
          ],
        ),
      ),
    );
  }
}
