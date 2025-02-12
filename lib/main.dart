import 'package:app_passo/models/alarmmodel.dart';
import 'package:app_passo/view/createalarm.dart';
import 'package:app_passo/view/homescreen.dart';
import 'package:app_passo/view/sounalarm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlarmModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        '/createalarm': (context) => const CreateAlarm(),
        '/homescreen': (context) => const MyHomePage(),
        '/soundalarm': (context) => const SoundAlarm(
              initialTone: '',
            ),
      },
    );
  }
}
