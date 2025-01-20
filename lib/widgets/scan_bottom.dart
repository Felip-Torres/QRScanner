import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        // Solicitar permiso de cámara
        var status = await Permission.camera.status;
        if (!status.isGranted) {
          status = await Permission.camera.request();
        }

        if (status.isGranted) {
          print('Botó polsat!');
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#3D88EF", "Cancelar", false, ScanMode.QR);
          print(barcodeScanRes);
          final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
          ScanModel scan = ScanModel(valor: barcodeScanRes);
          scanListProvider.nouScan(barcodeScanRes);
          launchURL(context, scan);
        } else {
          // Manejar el caso en que el permiso no fue concedido
          print('Permiso de cámara no concedido');
        }
      },
    );
  }
}
