import 'package:flutter/material.dart';

class SoundAlarm extends StatelessWidget {
  const SoundAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Alarm'),
      ),
      body: Center(
        child: const Text('Sound Alarm Settings'),
      ),
    );
  }
}
