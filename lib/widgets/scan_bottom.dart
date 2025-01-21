import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/qr_scanner_screen.dart';
import 'package:qr_scan/utils/utils.dart';


//Widget para el boton de escanear
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
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRScannerScreen()),
        );

        if (result != null) {
          ScanModel scan = ScanModel(valor: result);
          scanListProvider.nouScan(result);
          if (scan.tipus == 'http')launchURL(context, scan);
          else Navigator.pushNamed(context, 'mapa', arguments: scan);
        }
      },
    );
  }
}
