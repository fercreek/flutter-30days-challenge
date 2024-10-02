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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario - Día 7'),
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
                onSaved: (value) {
                  setState(() {
                    _name = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              // Campo de Correo
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
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
