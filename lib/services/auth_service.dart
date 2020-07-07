import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future<FirebaseUser> signInWithEmailAndPassword(
      String userName, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: userName, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      throw e;
    }
  }
}
