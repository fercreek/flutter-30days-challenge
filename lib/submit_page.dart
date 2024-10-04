import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmitPage extends StatefulWidget {
  const SubmitPage({super.key});

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _body = '';
  bool _isSubmitting = false;

  // Función para enviar datos a la API
  Future<void> submitData() async {
    setState(() {
      _isSubmitting = true;
    });

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': _title,
        'body': _body,
        'userId': 1,  // Puedes ajustar estos valores según sea necesario
      }),
    );

    if (response.statusCode == 201) {
      // Si la solicitud es exitosa, puedes mostrar un mensaje o hacer alguna acción
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos enviados exitosamente')),
      );
      setState(() {
        _title = '';
        _body = '';
      });
    } else {
      // Si hay un error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar los datos')),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Datos a la API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contenido'),
                onChanged: (value) {
                  setState(() {
                    _body = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el contenido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitData();
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
