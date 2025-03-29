import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AssistIntelligent extends StatefulWidget {
  const AssistIntelligent({super.key});

  @override
  State<AssistIntelligent> createState() => _AssistIntelligentState();
}

class _AssistIntelligentState extends State<AssistIntelligent> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isAuthenticated = false;
  String _clothingSuggestion = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchClothingSuggestion();
  }

  // Simulación de recomendación de ropa basada en clima
  Future<void> _fetchClothingSuggestion() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _clothingSuggestion = "Chaqueta y pantalón largo - 15°C";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Sugerencias de Inicio del Día',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '2️⃣ Sugerencia de Ropa:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              _clothingSuggestion,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
