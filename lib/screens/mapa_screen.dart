import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition _puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('id1'),
      position: scan.getLatLng(),
    )); 

    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.hybrid,
        markers: markers,
        initialCameraPosition: _puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
