import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List _todos = [];  // Aquí almacenaremos los datos obtenidos de la API

  @override
  void initState() {
    super.initState();
    fetchTodos();  // Llamamos a la función cuando la pantalla se inicializa
  }

  // Función para hacer una solicitud GET a la API
  Future<void> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        // Convertimos la respuesta a un formato que Flutter pueda manejar
        setState(() {
          _todos = json.decode(response.body);
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (error) {
      // Manejamos posibles errores
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas (API)'),
      ),
      body: _todos.isEmpty
          ? const Center(child: CircularProgressIndicator())  // Indicador de carga
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]['title']),  // Título de la tarea
                  leading: Icon(
                    _todos[index]['completed'] ? Icons.check_box : Icons.check_box_outline_blank,
                  ),  // Icono basado en el estado de completado
                );
              },
            ),
    );
  }
}
