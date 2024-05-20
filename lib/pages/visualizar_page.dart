import 'package:flutter/material.dart';
class VisualizarPage extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  VisualizarPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Registros'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          Color dotColor;

          if (item['hora_salida'] != null) {
            dotColor = Colors.black;
          } else if (item['hora_llegada'] != null) {
            dotColor = Colors.green;
          } else {
            dotColor = Colors.grey;
          }

          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: dotColor,
                radius: 20,
              ),
              title: Text(
                '${item['nombre_visitante']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item['hora_salida'] != null
                    ? 'Hora de salida: ${item['hora_salida']}'
                    : item['hora_llegada'] != null
                        ? 'Hora de llegada: ${item['hora_llegada']}'
                        : 'Registro pendiente',
                style: TextStyle(fontSize: 14),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetallePage(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
class DetallePage extends StatelessWidget {
  final Map<String, dynamic> item;

  DetallePage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
                headingTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                dataTextStyle: TextStyle(
                  fontSize: 16,
                ),
                columnSpacing: 20.0,
                columns: [
                  DataColumn(
                    label: Text(
                      'Campo',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Valor',
                    ),
                  ),
                ],
                rows: [
                  buildDataRow('ID', item['ID'].toString()),
                  buildDataRow('Nombre visitante', item['nombre_visitante'] ?? ''),
                  buildDataRow('Nombre visita', item['nombre_visita'] ?? ''),
                  buildDataRow('Empresa', item['empresa'] ?? ''),
                  buildDataRow('Motivo', item['motivo'] ?? ''),
                  buildDataRow('Material', item['material'] ?? ''),
                  buildDataRow('Hora Llegada', item['hora_llegada'] ?? ''),
                  buildDataRow('Hora Salida', item['hora_salida'] ?? ''),
                  buildDataRow('Vehículo', item['vehiculo'] == true ? 'Sí' : 'No'),
                  buildDataRow('Modelo', item['modelo'] ?? ''),
                  buildDataRow('Placas', item['placas'] ?? ''),
                  buildDataRow('Usuario', item['usuario'] ?? ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String label, String value) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        DataCell(
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}