import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 12),
            const Text('User Name', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('user@example.com'),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
