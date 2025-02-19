import 'dart:async';
import 'package:app_passo/models/alarmmodel.dart';
import 'package:app_passo/models/weathermodel.dart';
import 'package:app_passo/services/weather_service.dart';
import 'package:app_passo/view/alarmscreen.dart';
import 'package:app_passo/view/createalarm.dart';
import 'package:app_passo/view/weather.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentTime = DateFormat('HH:mm').format(DateTime.now());
  final _weatherService = WeatherService('e3d045cd24f4db577df419a77e054b54');
  late AudioPlayer _audioPlayer;
  late AlarmModel _alarmModel;
  List<WeatherModel> _hourlyForecast = [];
  bool isLoading = true;
  WeatherModel? _weather;
  late Timer _timer;
  bool isSwitched = true;
  bool isEditing = false;
  List<bool> selectedAlarms = [];
  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _audioPlayer = AudioPlayer(); // Inicialización del AudioPlayer
    Provider.of<AlarmModel>(context, listen: false).loadAlarms();
    _timer = Timer.periodic(const Duration(seconds: 60), (Timer timer) {
      setState(() {
        currentTime = DateFormat('HH:mm').format(DateTime.now());
      });
      for (var alarm
          in Provider.of<AlarmModel>(context, listen: false).alarms) {
        if (alarm.hour == DateTime.now().hour &&
            alarm.minute == DateTime.now().minute) {
          _triggerAlarm(alarm);
        }
      }
    });
  }

  _fetchWeather() async {
    if (!mounted)
      return; // Verifica si el widget sigue montado antes de actualizar el estado

    setState(() {
      isLoading = true; // Activa la animación de carga
    });

    var locationData = await _weatherService.getCurrentLocation();
    try {
      final forecast = await _weatherService.getHourlyWeather(
          locationData['lat'], locationData['lon']);

      if (!mounted) return; // Verifica nuevamente antes de actualizar el estado

      setState(() {
        _hourlyForecast = forecast;
        _weather = WeatherModel(
          cityName: locationData['city'],
          temperature: forecast.isNotEmpty ? forecast[0].temperature : 0.0,
          mainCondition:
              forecast.isNotEmpty ? forecast[0].mainCondition : "Unknown",
          humidity: forecast.isNotEmpty ? forecast[0].humidity : 0.0,
          windSpeed: forecast.isNotEmpty ? forecast[0].windSpeed : 0.0,
          feelsLike: forecast.isNotEmpty ? forecast[0].feelsLike : 0.0,
          time: forecast.isNotEmpty ? forecast[0].time : '',
        );
        isLoading = false;
      });
    } catch (e) {
      print(e);
      if (!mounted)
        return; // Evita actualizar el estado si el widget ya no existe
      setState(() {
        isLoading = false; // En caso de error, también oculta la animación
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _alarmModel = Provider.of<AlarmModel>(context, listen: false);
    // Si el WeatherModel se actualiza, reconstruir la vista.
    final weatherData = Provider.of<WeatherModel>(context);
    if (weatherData != null) {
      // Aquí puedes actualizar la UI si los datos cambiaron
    }
  }

  void _triggerAlarm(Alarm alarm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Alarmscreen(alarm: alarm),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _alarmModel.saveAlarms(); // Usamos la referencia guardada en vez de context
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Resetear la selección de alarmas al salir del modo de edición
        selectedAlarms = List<bool>.filled(selectedAlarms.length, false);
      }
    });
  }

  void deleteSelectedAlarms(AlarmModel alarmModel) {
    setState(() {
      // Eliminar las alarmas seleccionadas
      for (int i = selectedAlarms.length - 1; i >= 0; i--) {
        if (selectedAlarms[i]) {
          alarmModel.removeAlarm(i); // Eliminar la alarma seleccionada
        }
      }
      // Reiniciar la selección
      selectedAlarms = List<bool>.filled(alarmModel.alarms.length, false);
    });
  }

  void sortAlarms(AlarmModel alarmModel) {
    setState(() {
      alarmModel.alarms.sort((a, b) {
        final aTime = a.hour * 60 + a.minute;
        final bTime = b.hour * 60 + b.minute;
        return aTime.compareTo(bTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherModel>(context);
    final alarmModel = Provider.of<AlarmModel>(context);
    if (selectedAlarms.length != alarmModel.alarms.length) {
      selectedAlarms = List<bool>.filled(alarmModel.alarms.length, false);
    }
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        backgroundColor: const Color(0xff141414),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: () {
                toggleEditing(); // Cambia a modo de vista normal
              },
            ),
          PopupMenuButton<String>(
            color: Colors.black,
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            onSelected: (String result) {
              if (result == 'Editar') {
                toggleEditing(); // Entrar o salir del modo de edición
              } else if (result == 'Ordenar') {
                sortAlarms(alarmModel);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Editar',
                child: Text(
                  'Editar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Ordenar',
                child: Text('Ordenar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentTime, // Hora actual
                    style: GoogleFonts.aboreto(
                      color: Color(0xFFFFFFFF),
                      fontSize: 60,
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Espacio entre la hora y la ciudad
                  Text(
                    _weather?.cityName ?? '', // Ciudad actual
                    style: GoogleFonts.aBeeZee(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Alarmas Activas',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'JosefinSans-SemiBold',
                    ),
                  ),
                ),
              ),
              alarmModel.alarms.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/alarma.json', // Asegúrate de tener esta animación en tu carpeta assets
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No hay alarmas creadas. ¡Crea una nueva alarma!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: 'JosefinSans-Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: alarmModel.alarms.map((alarm) {
                          int index = alarmModel.alarms.indexOf(alarm);
                          return GestureDetector(
                            onTap: () {
                              if (isEditing) {
                                setState(() {
                                  selectedAlarms[index] = !selectedAlarms[
                                      index]; // Alternar la selección
                                });
                              } else {
                                // Normal: Navegar a la pantalla de creación de alarma
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateAlarm(existingAlarm: alarm),
                                  ),
                                );
                              }
                            },
                            child: Card(
                              color: alarm.isActive
                                  ? const Color(0xFF2E44AF)
                                  : const Color(0xff141414),
                              elevation: 6,
                              shadowColor: const Color(0xFF2643D4),
                              margin: const EdgeInsets.all(7),
                              child: ListTile(
                                leading: isEditing
                                    ? Checkbox(
                                        value: selectedAlarms[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedAlarms[index] = value!;
                                          });
                                        },
                                      )
                                    : null,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      alarm.subject,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'JosefinSans-SemiBold',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${alarm.hour}:${alarm.minute.toString().padLeft(2, '0')} ${alarm.timeFormat}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'JosefinSans-Light',
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "${alarm.selectedDays.entries.where((entry) => entry.value).map((entry) => entry.key).join(', ')}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'JosefinSans-Regular',
                                  ),
                                ),
                                trailing: isEditing
                                    ? IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            alarmModel.removeAlarm(index);
                                            selectedAlarms = List<bool>.filled(
                                                alarmModel.alarms.length,
                                                false); // Resetear selección
                                          });
                                        },
                                      )
                                    : Switch(
                                        value: alarm.isActive,
                                        onChanged: (value) {
                                          setState(() {
                                            alarmModel.toggleAlarm(index);
                                            isSwitched = value;
                                          });
                                        },
                                        activeColor: Colors.blueAccent,
                                        focusColor: Colors.blueGrey,
                                        activeTrackColor:
                                            const Color(0xFF000000),
                                      ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(top: 10),
      //   child: FloatingActionButton(
      //     backgroundColor: const Color(0xff141414),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => const CreateAlarm()),
      //       );
      //     },
      //     child: Lottie.asset(
      //       'assets/add_alarm.json',
      //       width: 70,
      //       height: 70,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
    );
  }
}
