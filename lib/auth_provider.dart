import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;

  // Método para verificar si el token existe en shared_preferences
  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    _isAuthenticated = _token != null;
    notifyListeners();  // Notifica a los listeners para actualizar la UI
  }

  // Método para iniciar sesión y guardar el token
  Future<void> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _token = token;
    _isAuthenticated = true;
    notifyListeners();  // Notifica a los listeners
  }

  // Método para cerrar sesión y eliminar el token
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
    _isAuthenticated = false;
    notifyListeners();  // Notifica a los listeners
  }
}
