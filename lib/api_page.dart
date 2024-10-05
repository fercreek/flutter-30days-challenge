import 'package:flutter/material.dart';
import 'api_service.dart';  // Importa el servicio de la API

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late Future<List<dynamic>> _users;

  @override
  void initState() {
    super.initState();
    _users = ApiService().fetchUsers();  // Obtenemos los datos al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la API'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // Muestra un spinner mientras carga
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));  // Muestra el error si ocurre
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron datos'));  // Muestra si no hay datos
          } else {
            // Si los datos son exitosamente obtenidos, los mostramos en una lista
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var user = snapshot.data![index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
