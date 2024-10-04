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

  // Validación adicional para campos vacíos o demasiado cortos
  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un título';
    } else if (value.length < 5) {
      return 'El título debe tener al menos 5 caracteres';
    }
    return null;
  }

  String? _validateBody(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un contenido';
    } else if (value.length < 10) {
      return 'El contenido debe tener al menos 10 caracteres';
    }
    return null;
  }

  // Función para enviar datos a la API
  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
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
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        // Si la solicitud es exitosa
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos enviados exitosamente')),
        );
        setState(() {
          _title = '';
          _body = '';
        });
      } else {
        // Si ocurre un error en la solicitud
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al enviar los datos')),
        );
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Datos con Validación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Campo de Título con validación
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                validator: _validateTitle,
              ),
              const SizedBox(height: 20),
              // Campo de Contenido con validación
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contenido'),
                onChanged: (value) {
                  setState(() {
                    _body = value;
                  });
                },
                validator: _validateBody,
              ),
              const SizedBox(height: 40),
              _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: submitData,
                      child: const Text('Enviar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
