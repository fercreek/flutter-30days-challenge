import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'summary_page.dart';
import 'counter_provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // Método para cargar los datos guardados localmente
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  // Método para guardar los datos localmente
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
    await prefs.setString('email', _email);
  }

  // Validar correo
  String? _validateEmail(String? value) {
    final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  // Reiniciar formulario y contador de envíos
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _name = '';
      _email = '';
    });
    Provider.of<CounterProvider>(context, listen: false).resetSubmissionCount();
    _saveData(); // Guardar los datos vacíos
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context); // Acceso a CounterProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulario con Persistencia',
          style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.blue,  // Cambiado a azul
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo de Nombre
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              // Campo de Correo
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              // Añadir Hero Animation al botón de envío
              Hero(
                tag: 'submitPageButton',  // Identificador único para la animación
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      counterProvider.incrementSubmissionCount(); // Incrementar el contador de envíos
                      _saveData(); // Guardar los datos
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryPage(
                            name: _name,
                            email: _email,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,  // Cambiado a azul
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Mostrar el contador de envíos
              Text(
                'Formulario enviado ${counterProvider.submissionCount} veces',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Botón para reiniciar el formulario y el contador
              ElevatedButton(
                onPressed: _resetForm,
                child: const Text('Resetear Formulario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
