abstract class AuthService {
  String getUID();
  Future signIn(String email, String password);
  Future signUp(String email,String password);
  Future<void> resetPassword(String email);
  Future signOut();
}
