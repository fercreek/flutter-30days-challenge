import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  // Método para validar correo
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
        title: const Text('Formulario con Validaciones - Día 8'),
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
                  setState(() {
                    _name = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              // Campo de Correo con validación
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: _validateEmail,  // Utilizamos la función de validación personalizada
                onSaved: (value) {
                  setState(() {
                    _email = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 20),
              // Botón para enviar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: const Text('Enviar'),
              ),
              const SizedBox(height: 20),
              // Mostrar los datos ingresados
              Text('Nombre: $_name'),
              Text('Correo: $_email'),
            ],
          ),
        ),
      ),
    );
  }
}
