import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _api = ApiService();
  final _auth = AuthService();
  Map<String, dynamic>? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final u = await _api.getMe();
    setState(() {
      _user = u;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(radius: 40, child: Text((_user?['name'] ?? 'U').toString()[0])),
                  const SizedBox(height: 12),
                  Text(_user?['name'] ?? 'User', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(_user?['email'] ?? ''),
                  const SizedBox(height: 24),
                  ElevatedButton(onPressed: _logout, child: const Text('Logout')),
                ],
              ),
            ),
    );
  }
}
