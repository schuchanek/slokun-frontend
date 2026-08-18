import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/location_provider.dart';
import '../services/venue_service.dart';
import 'venue_detail_screen.dart';

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

  final _nameController = TextEditingController();
  double _radius = 5.0; // km

  @override
  void initState() {
    super.initState();
    _loadNearby();
  }

  Future<void> _loadNearby({String? nameFilter}) async {
    setState(() => _loading = true);
    final pos = await _locationSvc.determinePosition();
    final lat = pos?.latitude ?? _initial.latitude;
    final lng = pos?.longitude ?? _initial.longitude;
    final list = await _venueSvc.getNearby(lat, lng, radius: _radius.toInt());
    final markers = <Marker>{};
    for (final v in list) {
      try {
    final id = v['id'].toString();
    final name = v['name'] ?? 'Venue';
    if (nameFilter != null && nameFilter.isNotEmpty) {
      if (!name.toString().toLowerCase().contains(nameFilter.toLowerCase())) continue;
    }
    final latvRaw = v['location']?['lat'] ?? lat;
    final lngvRaw = v['location']?['lng'] ?? lng;
    final latv = (latvRaw is num) ? latvRaw.toDouble() : double.tryParse(latvRaw.toString()) ?? lat;
    final lngv = (lngvRaw is num) ? lngvRaw.toDouble() : double.tryParse(lngvRaw.toString()) ?? lng;
    markers.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(latv, lngv),
        infoWindow: InfoWindow(title: name),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => VenueDetailScreen(id: id, name: name)));
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
      body: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search by name'),
                onSubmitted: (v) => _loadNearby(nameFilter: v),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: () => _loadNearby(nameFilter: _nameController.text), child: const Text('Search'))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Text('Radius (km):'),
            Expanded(
              child: Slider(
                value: _radius,
                min: 1,
                max: 50,
                divisions: 49,
                label: _radius.toStringAsFixed(0),
                onChanged: (v) => setState(() => _radius = v),
                onChangeEnd: (_) => _loadNearby(nameFilter: _nameController.text),
              ),
            ),
            Text('${_radius.toStringAsFixed(0)} km')
          ],
        ),
      ),
      Expanded(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(target: _initial, zoom: 12),
                onMapCreated: (c) => _controller = c,
                markers: _markers,
              ),
      ),
    ],
      ),
    );
  }
}
