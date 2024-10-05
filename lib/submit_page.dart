import 'package:flutter/material.dart';
import 'api_service.dart';  // Importa el servicio de la API

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key}) : super(key: key);

  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  // Validación del correo electrónico
  String? _validateEmail(String? value) {
    const emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  // Validación del nombre
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre';
    }
    return null;
  }

  // Método para manejar el envío de datos
  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;  // Estado de carga activado
      });

      try {
        final response = await ApiService().submitData(
          _nameController.text,
          _emailController.text,
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Datos enviados correctamente')),
          );
        } else {
          throw Exception('Error en el envío');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;  // Estado de carga desactivado
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Envío'),
        backgroundColor: Colors.deepPurple,  // Mejoramos el color del AppBar
      ),
      body: SingleChildScrollView(  // Añadimos scroll por si el teclado cubre los campos
        padding: const EdgeInsets.all(20.0),  // Añadimos padding en toda la pantalla
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Ingresa tus Datos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,  // Color llamativo para el título
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,  // Asociamos el formulario a una clave global
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    validator: _validateName,  // Validación del nombre
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Correo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,  // Validación del correo
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()  // Spinner durante la carga
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Colors.deepPurple,  // Botón estilizado
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _submitData,
                              child: const Text(
                                'Enviar Datos',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                  ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
