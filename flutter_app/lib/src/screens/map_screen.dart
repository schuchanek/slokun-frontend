import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/location_provider.dart';
import '../services/venue_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final LatLng _initial = const LatLng(47.4979, 19.0402); // Budapest fallback
  Set<Marker> _markers = {};
  bool _loading = true;

  final _venueSvc = VenueService();
  final _locationSvc = LocationService();

  @override
  void initState() {
    super.initState();
    _loadNearby();
  }

  Future<void> _loadNearby() async {
    final pos = await _locationSvc.determinePosition();
    final lat = pos?.latitude ?? _initial.latitude;
    final lng = pos?.longitude ?? _initial.longitude;
    final list = await _venueSvc.getNearby(lat, lng);
    final markers = <Marker>{};
    for (final v in list) {
      try {
        final id = v['id'].toString();
        final name = v['name'] ?? 'Venue';
        final latv = (v['location']?['lat'] ?? lat) as double;
        final lngv = (v['location']?['lng'] ?? lng) as double;
        markers.add(Marker(markerId: MarkerId(id), position: LatLng(latv, lngv), infoWindow: InfoWindow(title: name), onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => VenueDetailScreen(name: name)));
        }));
      } catch (_) {}
    }
    setState(() {
      _markers = markers;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: _initial, zoom: 12),
              onMapCreated: (c) => _controller = c,
              markers: _markers,
            ),
    );
  }
}
