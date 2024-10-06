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
  int _currentMax = 10; 
  bool _hasError = false;  

  @override
  void initState() {
    super.initState();
    _users = ApiService().fetchUsers(); 
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener); 
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadMoreData();  
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;  
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _currentMax += 10;  
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;  
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,  
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
                child: CircularProgressIndicator(color: Colors.blue),  
              );
            } else if (snapshot.hasError) {
              return _buildErrorUI();
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No se encontraron datos',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return RepaintBoundary(  
                child: ListView.builder(
                  controller: _scrollController,  
                  itemCount: (_currentMax <= snapshot.data!.length) ? _currentMax + 1 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (index == _currentMax && _currentMax <= snapshot.data!.length) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),  
                      );
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

  Widget _buildErrorUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
          const SizedBox(height: 10),
          const Text(
            'Ocurrió un error al cargar los datos',
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadMoreData,
            child: const Text('Reintentar'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();  
    super.dispose();
  }
}
