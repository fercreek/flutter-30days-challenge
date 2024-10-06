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
        backgroundColor: Colors.blue,  // Cambiado a azul
        title: const Text(
          'Datos de la API',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,  // Cambiado a azul
                ),
              );  // Muestra un spinner mientras carga
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
                    const SizedBox(height: 10),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                    ),
                  ],
                ),
              );  // Muestra el error si ocurre
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No se encontraron datos',
                  style: TextStyle(fontSize: 18),
                ),
              );  // Muestra si no hay datos
            } else {
              // Si los datos son exitosamente obtenidos, los mostramos en una lista
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var user = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade700,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          user['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(user['email']),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
