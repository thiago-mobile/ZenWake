import 'package:app_passo/models/sleeprecord.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SleepStatsScreen extends StatelessWidget {
  const SleepStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Consumer<SleepModel>(
    builder: (context, sleepModel, child) {
      final records = sleepModel.records;

      final sleepHours = records.isNotEmpty
          ? records.map((e) => e.hoursSlept).reduce((a, b) => a + b) / records.length
          : 0.0;

      final challengeErrors = records.fold(0, (a, b) => a + b.challengeErrors);
      double rawScore = (sleepHours >= 7 ? 100 : (sleepHours / 7) * 100) - (challengeErrors * 5);
      final performanceScore = rawScore.clamp(0, 100);
    final tips = [
      "Evitá pantallas al menos 30 minutos antes de dormir",
      "Cená ligero y al menos 2h antes de acostarte",
      "Usá sonidos relajantes para conciliar el sueño",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Center(
          child: Text(
            'Resumen💤',
            style: TextStyle(color: Colors.white, fontFamily: "JoseFinSans-Regular"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Lottie.asset(
                      'assets/sleeping.json',
                      width: 150,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildStatCard(
                          title: "Horas dormidas",
                          value: "${sleepHours.toStringAsFixed(1)} h",
                          animation: 'assets/alarma.json',
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 16),
                        _buildStatCard(
                          title: "Errores en desafío",
                          value: "$challengeErrors",
                          animation: 'assets/clima_load.json',
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 16),
                        _buildStatCard(
                          title: "Puntaje de desempeño",
                          value: "${performanceScore.toStringAsFixed(1)}%",
                          animation: 'assets/nube.json',
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "🛏️ Consejos para dormir mejor",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "JoseFinSans-SemiBold",
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...tips.map((tip) => _buildTipCard(tip)).toList(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
    }
  );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String animation,
    required Color color,
  }) {
    return Card(
      color: Color.fromARGB(48, 46, 67, 175),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: ListTile(
        leading: Lottie.asset(animation, width: 50),
        title: Text(title,
            style: TextStyle(color: Colors.white70, fontSize: 18)),
        subtitle: Text(value,
            style: TextStyle(color: color, fontSize: 22, fontFamily: "JoseFinSans-SemiBold")),
      ),
    );
  }

  Widget _buildTipCard(String tip) {
    return Card(
      color: Color.fromARGB(189, 37, 37, 39),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.nightlight_round, color: Colors.amberAccent),
        title: Text(
          tip,
          style: const TextStyle(color: Colors.white, fontSize: 16,fontFamily: "JoseFinSans-SemiBold"),
        ),
      ),
    );
  }
}
