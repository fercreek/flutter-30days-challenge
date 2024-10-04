import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'todo.dart'; // Importa el modelo Todo

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List<Todo> _todos = [];  // Almacenamos los datos como una lista de objetos Todo

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _todos = data.map((json) => Todo.fromJson(json)).toList(); // Parseamos JSON a objetos Todo
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (error) {
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
                  title: Text(_todos[index].title),  // Usamos el título del objeto Todo
                  leading: Icon(
                    _todos[index].completed ? Icons.check_box : Icons.check_box_outline_blank,
                  ),  // Icono basado en el estado de completado
                );
              },
            ),
    );
  }
}
