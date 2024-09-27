import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Volver a la pantalla principal
            Navigator.pop(context);
          },
          child: const Text('Back to Home Page'),
        ),
      ),
    );
  }
}
