import 'package:flutter/material.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget de Ejemplo'),
        ),
        body: Center(
          child: MyWidget(), // Aquí se llama al widget personalizado
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text(
          '¡Hola, este es mi widget personalizado!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
