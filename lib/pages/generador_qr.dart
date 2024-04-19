import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorPage extends StatelessWidget {
  final String qrData;

  const QRGeneratorPage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Código QR'),
      ),
       body: Center(
          child: QrImageView(
            data: qrData,
            size: 280,
            // You can include embeddedImageStyle Property if you 
            //wanna embed an image from your Asset folder
            embeddedImageStyle: const QrEmbeddedImageStyle(
              size:  Size(
                100,
                100,
              ),
            ),
          ),
        ),
     );
   }
}