import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // URL de ejemplo para obtener datos de usuarios
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  // Método para obtener los datos de la API
  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Si la petición es exitosa, decodificamos los datos
        return json.decode(response.body);
      } else {
        // Si la petición falla, lanzamos un error
        throw Exception('Error al obtener los datos');
      }
    } catch (error) {
      throw Exception('Error de conexión: $error');
    }
  }
}
