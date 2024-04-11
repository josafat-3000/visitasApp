import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GenerarVisita extends StatefulWidget {
  @override
  _GenerarVisitaState createState() => _GenerarVisitaState();
}

class _GenerarVisitaState extends State<GenerarVisita> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    try {
      final form = _formKey.currentState;
      if (form!.validate()) {
        await supabase.auth.signInWithPassword(
          password: _passwordController.text.trim(),
          email: _usernameController.text.trim(),
        );
        if (!mounted) return;

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 132, 193),
        title: Image.asset(
          'lib/images/virtu.png',
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                    'Por favor, Introduce tus credenciales',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 30),
                  const SizedBox(width: 30),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Correo electrónico",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa tu correo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Contraseña",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 11, 132, 193), // Color de fondo del botón
                      padding: const EdgeInsets.all(
                          25), // Espaciado interno del botón
                      shape: RoundedRectangleBorder(
                        // Forma del botón
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: double
                          .infinity, // Ajusta el ancho del botón al ancho disponible
                      alignment:
                          Alignment.center, // Centra el contenido del botón
                      child: const Text(
                        'Iniciar Sesión', // Texto del botón
                        style: TextStyle(
                          color: Colors.white, // Color del texto
                          fontWeight: FontWeight.bold, // Peso de la fuente
                          fontSize: 16, // Tamaño de la fuente
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
