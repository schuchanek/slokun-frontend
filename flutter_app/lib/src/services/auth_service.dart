import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api_service.dart';
import 'local_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final LocalStorage _storage = LocalStorage();
  final ApiService _api = ApiService();

  // Email/password via backend
  Future<bool> loginWithEmail(String email, String password) async {
    return await _api.login(email, password);
  }

  Future<Map<String, dynamic>> registerWithEmail(String email, String password) async {
    return await _api.register(email, password);
  }

  // Google sign-in (client-side) then send idToken to backend
  Future<bool> signInWithGoogleToBackend() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return false;
    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null) return false;
    return await _api.loginWithGoogleIdToken(idToken);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _storage.clearTokens();
  }
}
