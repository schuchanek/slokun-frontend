import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'local_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final LocalStorage _storage = LocalStorage();

  Future<UserCredential?> signInWithGoogle() async {
    // Note: requires correct Firebase initialization & Google OAuth client IDs
    final account = await _googleSignIn.signIn();
    if (account == null) return null;
    final auth = await account.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
    final result = await _auth.signInWithCredential(credential);
    // store idToken as JWT placeholder
    final token = await result.user?.getIdToken();
    if (token != null) await _storage.saveToken(token);
    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _storage.clearToken();
  }
}
