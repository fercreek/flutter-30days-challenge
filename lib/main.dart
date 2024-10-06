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
import 'theme_provider.dart';  // Importamos el ThemeProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),  // Agregamos el ThemeProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: const CheckAuth(),  // Pantalla inicial de verificación de autenticación
    );
  }
}
