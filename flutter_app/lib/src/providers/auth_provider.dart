import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider = StateProvider<bool>((ref) => false);

// Example async notifier to sign in
final authNotifierProvider = Provider((ref) {
  final svc = ref.read(authServiceProvider);
  return svc;
});
