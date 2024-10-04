import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';

class SummaryPage extends StatelessWidget {
  final String name;
  final String email;

  const SummaryPage({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context); // Acceso a CounterProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Datos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nombre: $name', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('Correo: $email', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 40),
            // Mostrar el contador de envíos en la página de resumen
            Text(
              'El formulario ha sido enviado ${counterProvider.submissionCount} veces',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Volver a la pantalla anterior
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
