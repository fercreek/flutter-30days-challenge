import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_provider.dart';
import 'second_page.dart';
import 'api_page.dart';
import 'submit_page.dart';
import 'login_page.dart';  // Importa la página de inicio de sesión

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '${counterProvider.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: counterProvider.resetCounter,
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: counterProvider.incrementCounter,
                  child: const Text('Increment'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: const Text('Go to Second Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApiPage()),
                );
              },
              child: const Text('View API Data'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SubmitPage()),
                );
              },
              child: const Text('Submit Data'),
            ),
            const SizedBox(height: 20),
            // Botón para ir a la pantalla de inicio de sesión
            ElevatedButton(
              onPressed: () {
                logout(context);  // Cierra sesión al presionar el botón
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterProvider.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
