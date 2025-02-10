import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundAlarm extends StatefulWidget {
  final String initialTone;
  const SoundAlarm({super.key, required this.initialTone});

  @override
  State<SoundAlarm> createState() => _SoundAlarmState();
}

class _SoundAlarmState extends State<SoundAlarm> {
  late String selectedTone;
  double _currentVolume = 0.5;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    selectedTone = widget.initialTone;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, selectedTone);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Sonido Alarma',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Josefinsans-Regular',
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.music_note,
                                color: Color(0xff2643d4),
                                size: 50,
                              ),
                            ),
                            const SizedBox(
                                width: 10), // Espacio entre el icono y el texto
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Melodias',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'JosefinSans-Light',
                                  ),
                                ),
                                const SizedBox(
                                    height: 5), // Espacio entre los textos
                                Text(
                                  selectedTone,
                                  style: const TextStyle(
                                    color: Color(0xff2643d4),
                                    fontSize: 15,
                                    fontFamily: 'JosefinSans-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          ListTile(
                            title: const Text(
                              'Cascada',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: selectedTone == 'Cascada'
                                  ? Colors.blue
                                  : Colors.grey, // Cambio de color
                            ),
                            onTap: () {
                              setState(() {
                                selectedTone = 'Cascada';
                                _audioPlayer.play(AssetSource('Cascada.mp3'));
                              });
                            },
                          ),
                          ListTile(
                            title: const Text(
                              'Lluvia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: selectedTone == 'Lluvia'
                                  ? Colors.blue
                                  : Colors.grey, // Cambio de color
                            ),
                            onTap: () {
                              setState(
                                () {
                                  selectedTone = 'Lluvia';
                                  _audioPlayer.play(AssetSource('lluvia.mp3'));
                                },
                              );
                            },
                          ),
                          ListTile(
                            title: const Text(
                              'Pajaros',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: selectedTone == 'Pajaros'
                                  ? Colors.blue
                                  : Colors.grey, // Cambio de color
                            ),
                            onTap: () {
                              setState(() {
                                selectedTone = 'Pajaros';
                                _audioPlayer.play(AssetSource('pajaros.mp3'));
                              });
                            },
                          ),
                          ListTile(
                            title: const Text(
                              'Olas del Mar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: selectedTone == 'Olas del Mar'
                                  ? Colors.blue
                                  : Colors.grey, // Cambio de color
                            ),
                            onTap: () {
                              setState(() {
                                selectedTone = 'Olas del Mar';
                                _audioPlayer
                                    .play(AssetSource('olas_de_mar.mp3'));
                              });
                            },
                          ),
                          ListTile(
                            title: const Text(
                              'Relajacion Melodia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'JosefinSans-Regular',
                              ),
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: selectedTone == 'Relajacion Melodia'
                                  ? Colors.blue
                                  : Colors.grey, // Cambio de color
                            ),
                            onTap: () {
                              setState(() {
                                selectedTone = 'Relajacion Melodia';
                                _audioPlayer
                                    .play(AssetSource('lluvia_relajacion.mp3'));
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 310,
                        height:
                            100, // Ajusta la altura para acomodar el nuevo texto
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C1C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.subway_rounded,
                                  color: Color(0xff2643d4),
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Espacio entre el icono y el texto
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Melodias ZenWake',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'JosefinSans-light',
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Despierta con noticias relevantes,',
                                    style: TextStyle(
                                      color: Color(0xff2643d4),
                                      fontSize: 16,
                                      fontFamily: 'JosefinSans-Regular',
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'el clima y la hora actual',
                                    style: TextStyle(
                                      color: Color(0xff2643d4),
                                      fontSize: 16,
                                      fontFamily: 'JosefinSans-Regular',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.volume_up, color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              value: _currentVolume,
                              min: 0,
                              max: 1,
                              onChanged: (double value) {
                                setState(() {
                                  _currentVolume = value;
                                  _audioPlayer.setVolume(_currentVolume);
                                });
                              },
                              activeColor: const Color(0xff2643d4),
                              inactiveColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
