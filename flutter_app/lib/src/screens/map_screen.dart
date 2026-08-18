import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final LatLng _initial = const LatLng(47.4979, 19.0402); // Budapest
  final Set<Marker> _markers = {
    const Marker(markerId: MarkerId('1'), position: LatLng(47.4979, 19.0402), infoWindow: InfoWindow(title: 'Sauna A')),
    const Marker(markerId: MarkerId('2'), position: LatLng(47.5, 19.03), infoWindow: InfoWindow(title: 'Sauna B')),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initial, zoom: 12),
        onMapCreated: (c) => _controller = c,
        markers: _markers,
      ),
    );
  }
}
