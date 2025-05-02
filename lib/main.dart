import 'package:app_passo/bloc/bottomNavBar.dart';
import 'package:app_passo/models/alarmmodel.dart';
import 'package:app_passo/models/sleeprecord.dart';
import 'package:app_passo/view/createalarm.dart';
import 'package:app_passo/view/homescreen.dart';
import 'package:app_passo/view/sounalarm.dart';
import 'package:app_passo/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'models/weathermodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlarmModel()),
        ChangeNotifierProvider(create: (_) => WeatherModel()),
        ChangeNotifierProvider(create: (_) => SleepModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => BottomNavCubit(),
        child: CustomNavigation(),
      ),
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
