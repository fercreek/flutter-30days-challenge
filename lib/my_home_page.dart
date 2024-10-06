import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_provider.dart';
import 'second_page.dart';
import 'api_page.dart';
import 'submit_page.dart';
import 'login_page.dart';  // Importa la página de inicio de sesión

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isVisible = true;  // Controla la visibilidad para la animación de opacidad

  // Método para cerrar sesión y eliminar el token
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');  // Elimina el token
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),  // Redirige a la página de inicio de sesión
    );
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,  // Cambiado a azul
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout(context);  // Llama al método de logout
            },
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,  // Cambiado a azul
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Has presionado el botón esta cantidad de veces:',
              style: TextStyle(fontSize: 18),
            ),
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,  // Cambia la opacidad del contador
              duration: const Duration(seconds: 1),  // Duración de la animación
              child: Text(
                '${counterProvider.counter}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,  // Cambiado a azul
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;  // Cambia la visibilidad para animar el contador
                    });
                    counterProvider.resetCounter();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text('Resetear', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;  // Cambia la visibilidad para animar el contador
                    });
                    counterProvider.incrementCounter();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Incrementar', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Añadir Hero Animation al botón para la Segunda Página
            Hero(
              tag: 'secondPageButton',  // Identificador único para la animación
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),  // Duración de la animación
                curve: Curves.easeInOut,  // Suaviza la animación
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,  // Cambiado a azul
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Ir a la Segunda Página',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Añadir Hero Animation al botón de la API
            Hero(
              tag: 'apiPageButton',  // Identificador único para la animación
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ApiPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,  // Cambiado a azul
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Ver Datos de la API',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Añadir Hero Animation al botón de Submit
            Hero(
              tag: 'submitPageButton',  // Identificador único para la animación
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SubmitPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,  // Cambiado a azul
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Enviar Datos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isVisible = !_isVisible;  // Cambia la visibilidad del contador
          });
        },
        backgroundColor: Colors.blue,  // Cambiado a azul
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
