import 'package:flutter/material.dart';
import '../services/venue_service.dart';

class VenueDetailScreen extends StatefulWidget {
  final String id;
  final String name;
  const VenueDetailScreen({super.key, required this.id, required this.name});

  @override
  State<VenueDetailScreen> createState() => _VenueDetailScreenState();
}

class _VenueDetailScreenState extends State<VenueDetailScreen> {
  final _venueSvc = VenueService();
  Map<String, dynamic>? _details;
  List<dynamic> _reviews = [];
  bool _loading = true;
  bool _attending = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final d = await _venueSvc.getDetails(widget.id);
    final r = await _venueSvc.getReviews(widget.id);
    setState(() {
      _details = d;
      _reviews = r;
      _loading = false;
    });
  }

  Future<void> _attend() async {
    final ok = await _venueSvc.attend(widget.id);
    if (ok) {
      setState(() => _attending = true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance recorded')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to record attendance')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 200, color: Colors.grey[300], child: const Center(child: Text('Image gallery placeholder'))),
                  const SizedBox(height: 12),
                  const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(_details?['description'] ?? 'No description'),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: _attending ? null : _attend, child: Text(_attending ? 'You are going' : 'I will be there')),
                  const SizedBox(height: 16),
                  const Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._reviews.map((r) => ListTile(title: Text(r['user'] ?? 'Anonymous'), subtitle: Text(r['comment'] ?? ''), trailing: Text('${r['rating'] ?? ''}'))).toList(),
                ],
              ),
            ),
    );
  }
}
