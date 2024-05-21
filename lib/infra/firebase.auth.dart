import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final User? user;
  final String? error;

  AuthResult({this.user, this.error});
}

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(user: userCredential.user);
    } catch (e) {
      return AuthResult(error: e.toString());
    }
  }

  Future<AuthResult> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(user: userCredential.user);
    } catch (e) {
      print('Error signing up: $e');
      return AuthResult(error: e.toString());
    }
  }
}
