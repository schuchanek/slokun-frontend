import 'package:flutter/material.dart';

class VenueDetailScreen extends StatelessWidget {
  final String name;
  const VenueDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 200, color: Colors.grey[300], child: const Center(child: Text('Image gallery placeholder'))),
            const SizedBox(height: 12),
            const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Information about the venue...'),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: const Text('I will be there')),
          ],
        ),
      ),
    );
  }
}
