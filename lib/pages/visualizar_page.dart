import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VisualizarPage extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  VisualizarPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];

    for (var item in data) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(item['id'].toString())),
          DataCell(Text(item['nombre'])),
          DataCell(Text(item['apellido'])),
          DataCell(Text(item['hora_llegada'] != null ? item['hora_llegada'].toString() : '')),
          DataCell(Text(item['hora_salida'] != null ? item['hora_salida'].toString() : '')),
          DataCell(Text(item['vehiculo'] ? 'Sí' : 'No')),
          DataCell(Text(item['modelo'])),
          DataCell(Text(item['placas'])),
          DataCell(Text(item['motivo'])),
          DataCell(Text(item['usuario'])),
        ],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Datos'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Apellido')),
              DataColumn(label: Text('Hora Llegada')),
              DataColumn(label: Text('Hora Salida')),
              DataColumn(label: Text('Vehículo')),
              DataColumn(label: Text('Modelo')),
              DataColumn(label: Text('Placas')),
              DataColumn(label: Text('Motivo')),
              DataColumn(label: Text('Usuario')),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}