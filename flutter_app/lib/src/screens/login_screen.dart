import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  final _auth = AuthService();

  void _login() async {
    setState(() => _loading = true);
    final ok = await _auth.loginWithEmail(_emailController.text.trim(), _passwordController.text.trim());
    setState(() => _loading = false);
    if (ok) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }

  void _googleSignIn() async {
    setState(() => _loading = true);
    final ok = await _auth.signInWithGoogleToBackend();
    setState(() => _loading = false);
    if (ok) Navigator.pop(context);
    else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google sign-in failed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            _loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _login, child: const Text('Login')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _googleSignIn, child: const Text('Sign in with Google')),
          ],
        ),
      ),
    );
  }
}
