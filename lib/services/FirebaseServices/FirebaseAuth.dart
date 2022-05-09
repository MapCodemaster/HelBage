import 'package:firebase_auth/firebase_auth.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String getUID() {
    return _auth.currentUser!.uid;
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
