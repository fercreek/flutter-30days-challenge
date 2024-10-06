import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'counter_provider.dart';
import 'locale_provider.dart';
import 'theme_provider.dart';
import 'app_localizations.dart';  // Importamos AppLocalizations
import 'check_auth.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),  // Soporte de idioma
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      locale: localeProvider.locale,  // Ajusta el idioma dinámico
      supportedLocales: const [
        Locale('en', ''),  // Inglés
        Locale('es', ''),  // Español
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),  // Nuestra clase de localización
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const CheckAuth(),
    );
  }
}
