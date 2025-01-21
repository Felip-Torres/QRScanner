import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

//Screen para los mapas
class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipus: 'geo');
  }
}
