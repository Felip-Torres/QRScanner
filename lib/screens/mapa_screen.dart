import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

//Screen para mostrar el mapa
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MapType _currentMapType = MapType.normal;

  
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition _puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    //Marcadores del mapa
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('id1'),
      position: scan.getLatLng(),
    )); 

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Mapa'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Botón para centrar el mapa en la posición actual
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              _controller.future.then((GoogleMapController controller) {
                controller.animateCamera(CameraUpdate.newCameraPosition(_puntoInicial));
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Mapa
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: _currentMapType,
            markers: markers,
            initialCameraPosition: _puntoInicial,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          // Dropdown para cambiar el tipo de mapa
          Positioned(
            bottom: 30,
            left: 10,
            child: Container(
              color: Colors.white, // Set the background color here
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: DropdownButton<MapType>(
                value: _currentMapType,
                icon: Icon(Icons.arrow_downward),
                onChanged: (MapType? newValue) {
                  setState(() {
                    _currentMapType = newValue!;
                  });
                },
                items: <MapType>[MapType.normal, MapType.satellite, MapType.terrain, MapType.hybrid]
                    .map<DropdownMenuItem<MapType>>((MapType value) {
                  return DropdownMenuItem<MapType>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
