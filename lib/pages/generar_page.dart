
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/pages/generador_qr.dart';

class GenerarVisita extends StatefulWidget {
  @override
  _GenerarVisitaState createState() => _GenerarVisitaState();
}

class _GenerarVisitaState extends State<GenerarVisita> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _motivoController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _placasController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _switchValue = false;

  Future<void> _submit(BuildContext context) async {
    try {
      final form = _formKey.currentState;
      if (form!.validate()) {
        // Obtener la sesión de usuario actual
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QRGeneratorPage(qrData: "12<<<345"))); 
        final User? user = supabase.auth.currentUser;
        await supabase.from('visitas_registro').insert({
          'usuario': user?.id,
          'nombre': _nombreController.text,
          'apellido': _apellidoController.text,
          'motivo': _motivoController.text,
          'vehiculo': _switchValue,
          'modelo': _modeloController.text,
          'placas': _placasController.text,
        });
        // Operación completada con éxito
        debugPrint('Operación de inserción completada con éxito');
        
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir durante el proceso
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 132, 193),
        title: Image.asset(
          'lib/images/virtu.png',
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        height:
                            20), // Espacio antes del texto "Por favor, Introduce tus datos"
                    Text(
                      'Por favor, Introduce tus datos',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa tu nombre ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _apellidoController,
                      decoration: const InputDecoration(
                        labelText: 'Apellido',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa tu apellido. ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _motivoController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Motivo de la visita',
                        hintText: 'Ingresa tu descripción aquí...',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa tu apellido. ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            '¿Trae vehículo?',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Switch(
                          value: _switchValue,
                          onChanged: (bool value) {
                            setState(() {
                              _switchValue = value;
                              print(value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_switchValue) ...[
                      TextFormField(
                        controller: _modeloController,
                        decoration: const InputDecoration(
                          labelText: 'Modelo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu apellido. ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _placasController,
                        decoration: const InputDecoration(
                          labelText: 'Palcas',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu apellido. ';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        _submit(context);
                        },
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
                          'Generar QR', // Texto del botón
                          style: TextStyle(
                            color: Colors.white, // Color del texto
                            fontWeight: FontWeight.bold, // Peso de la fuente
                            fontSize: 16, // Tamaño de la fuente
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
