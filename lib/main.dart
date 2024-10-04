import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_provider.dart';
import 'second_page.dart';
import 'counter_provider.dart';
import 'api_page.dart';
import 'submit_page.dart';
import 'login_page.dart';
import 'my_home_page.dart'; 
import 'splash_screen.dart';
import 'check_auth.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),  // Agrega el AuthProvider
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
