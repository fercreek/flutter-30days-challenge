import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_provider.dart';
import 'second_page.dart';
import 'api_page.dart';
import 'submit_page.dart';
import 'login_page.dart';
import 'theme_provider.dart';  // Importa el ThemeProvider
import 'locale_provider.dart';  // Importa LocaleProvider
import 'app_localizations.dart';  // Importa AppLocalizations para el manejo de idiomas

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
    final themeProvider = Provider.of<ThemeProvider>(context);  // Accedemos al ThemeProvider
    final localeProvider = Provider.of<LocaleProvider>(context);  // Accedemos al LocaleProvider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme ? Colors.grey[900] : Colors.blue,  // Color dinámico según el tema
        title: Text(
          AppLocalizations.of(context)!.translate('welcome'),  // Usamos la traducción para "Bienvenido"
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout(context);  // Llama al método de logout
            },
            tooltip: AppLocalizations.of(context)!.translate('logout'),  // Traducción para "Cerrar sesión"
          ),
          Switch(
            value: themeProvider.isDarkTheme,
            onChanged: (value) {
              themeProvider.toggleTheme();  // Alterna el tema
            },
            activeColor: Colors.white,
            activeTrackColor: themeProvider.isDarkTheme ? Colors.grey : Colors.blue.shade700,
          ),
          // Dropdown para cambiar de idioma
          DropdownButton<Locale>(
            value: localeProvider.locale,
            icon: const Icon(Icons.language, color: Colors.white),
            dropdownColor: themeProvider.isDarkTheme ? Colors.grey[800] : Colors.white,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                localeProvider.setLocale(newLocale.languageCode);  // Cambia el idioma
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('es'),
                child: Text('Español'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.translate('welcome'),  // Usamos la traducción para "Bienvenido"
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkTheme ? Colors.white : Colors.blue,  // Color dinámico
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.translate('counterMessage'),  // Traducción para el mensaje del contador
              style: const TextStyle(fontSize: 18),
            ),
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,  // Cambia la opacidad del contador
              duration: const Duration(seconds: 1),  // Duración de la animación
              child: Text(
                '${counterProvider.counter}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkTheme ? Colors.white : Colors.blue.shade700,  // Color dinámico
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
                    backgroundColor: themeProvider.isDarkTheme ? Colors.grey[800] : Colors.blue,  // Color dinámico
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.translate('secondPageButton'),  // Traducción para el botón "Ir a Segunda Página"
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                    backgroundColor: themeProvider.isDarkTheme ? Colors.grey[800] : Colors.blue,  // Color dinámico
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.translate('apiPageButton'),  // Traducción para el botón "Ver Datos de la API"
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                    backgroundColor: themeProvider.isDarkTheme ? Colors.grey[800] : Colors.blue,  // Color dinámico
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.translate('submitPageButton'),  // Traducción para el botón "Enviar Datos"
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
        backgroundColor: themeProvider.isDarkTheme ? Colors.grey[800] : Colors.blue,  // Color dinámico
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
