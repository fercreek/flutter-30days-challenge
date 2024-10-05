import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';  // API de ejemplo

  // Método para obtener datos (GET)
  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener los datos');
      }
    } catch (error) {
      throw Exception('Error de conexión: $error');
    }
  }

  // Método para enviar datos (POST)
  Future<http.Response> submitData(String name, String email) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
        }),
      );

      if (response.statusCode == 201) {
        return response;  // Retorna la respuesta exitosa
      } else {
        throw Exception('Error al enviar los datos');
      }
    } catch (error) {
      throw Exception('Error de conexión: $error');
    }
  }
}
