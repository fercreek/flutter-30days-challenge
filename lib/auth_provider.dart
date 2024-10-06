import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();  // Flutter Secure Storage
  bool _isAuthenticated = false;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;

  // Método para verificar si el token existe en flutter_secure_storage
  Future<void> checkAuthStatus() async {
    _token = await _storage.read(key: 'auth_token');
    _isAuthenticated = _token != null;
    notifyListeners();  // Notifica a los listeners para actualizar la UI
  }

  // Método para iniciar sesión y guardar el token en almacenamiento seguro
  Future<void> login(String token) async {
    await _storage.write(key: 'auth_token', value: token);
    _token = token;
    _isAuthenticated = true;
    notifyListeners();  // Notifica a los listeners
  }

  // Método para cerrar sesión y eliminar el token de almacenamiento seguro
  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _token = null;
    _isAuthenticated = false;
    notifyListeners();  // Notifica a los listeners
  }
}
