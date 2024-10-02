import 'package:flutter/material.dart';
import 'summary_page.dart'; // Importamos la pantalla de resumen

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  String? _validateEmail(String? value) {
    final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario con Resumen - Día 9'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo de Nombre con validación
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              // Campo de Correo con validación
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              // Botón para enviar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Navegar a la pantalla de resumen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryPage(
                          name: _name,
                          email: _email,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
