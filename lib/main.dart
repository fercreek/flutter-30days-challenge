import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'second_page.dart';
import 'counter_provider.dart';
import 'api_page.dart';
import 'submit_page.dart';
import 'login_page.dart';
import 'my_home_page.dart'; 
import 'splash_screen.dart';  // Importa el Splash Screen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontFamily: 'Arial'),
        ),
        useMaterial3: true,
      ),
      home: const CheckAuth(),  // Pantalla inicial de verificación de autenticación
    );
  }
}

// Nueva clase para verificar el estado de autenticación
class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  String? _token;
  bool _isLoading = true;  // Estado de carga para el Splash Screen

  @override
  void initState() {
    super.initState();
    _checkToken();  // Verificamos el token al iniciar
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');  // Obtenemos el token almacenado

    setState(() {
      _token = token;
      _isLoading = false;  // La verificación del token ha terminado
    });

    // Redirigir según el estado del token
    if (_token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();  // Muestra el splash screen mientras se verifica
    } else {
      return Container();  // Esta parte no debería verse ya que se hace el redireccionamiento
    }
  }
}
