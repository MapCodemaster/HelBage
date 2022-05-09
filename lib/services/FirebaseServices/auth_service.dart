abstract class AuthService {
  String getUID();
  Future signIn(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future signOut();
}
