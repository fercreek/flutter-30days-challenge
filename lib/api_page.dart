import 'package:flutter/material.dart';
import 'api_service.dart';  // Importa el servicio de la API

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late ScrollController _scrollController;
  late Future<List<dynamic>> _users;
  bool _isLoading = false;
  int _currentMax = 10; // Límite inicial de carga

  @override
  void initState() {
    super.initState();
    _users = ApiService().fetchUsers();  // Obtenemos los datos al iniciar la pantalla
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);  // Listener para el scroll
  }

  // Controlador del scroll que detecta cuando se llega al final
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadMoreData();  // Cargar más datos cuando se llega al final
    }
  }

  // Función para simular la carga de más datos
  void _loadMoreData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));  // Simula un retardo de carga

    setState(() {
      _currentMax += 10;  // Incrementa el límite de carga
      _isLoading = false;
    });
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
                child: CircularProgressIndicator(color: Colors.blue),  // Muestra un spinner mientras carga
              );
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
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No se encontraron datos',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              // Si los datos son exitosamente obtenidos, los mostramos en una lista
              return RepaintBoundary(  // Usamos RepaintBoundary para optimizar redibujos
                child: ListView.builder(
                  controller: _scrollController,  // Añadimos el controlador del scroll
                  itemCount: (_currentMax <= snapshot.data!.length) ? _currentMax + 1 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (index == _currentMax && _currentMax <= snapshot.data!.length) {
                      return const Center(child: CircularProgressIndicator(color: Colors.blue));  // Loader al final
                    }

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
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();  // Limpiamos el controlador del scroll
    super.dispose();
  }
}
