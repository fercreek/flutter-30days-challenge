import 'package:flutter/material.dart';
import 'summary_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  int _submissionCount = 0;  // Contador de envíos

  // Validar el formato del correo
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

  // Reiniciar todos los datos del formulario y el contador
  void _resetForm() {
    _formKey.currentState!.reset();  // Resetea los campos del formulario
    setState(() {
      _name = '';
      _email = '';
      _submissionCount = 0;  // Reiniciar contador
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario con Contador - Día 10'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo de Nombre
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
              // Campo de Correo
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              // Botón para enviar el formulario
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Incrementar el contador de envíos
                    setState(() {
                      _submissionCount++;
                    });
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
              const SizedBox(height: 20),
              // Mostrar el contador de envíos
              Text('Formulario enviado $_submissionCount veces', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              // Botón para reiniciar el formulario y el contador
              ElevatedButton(
                onPressed: _resetForm,
                child: const Text('Resetear Formulario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
