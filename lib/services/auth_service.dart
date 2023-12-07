import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sign in
  Future<User?> signInWithGoogle() async {
    print('fdasfsdf');
    try {
      //begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      print(gUser);

      if (gUser == null) {
        // Người dùng đã hủy đăng nhập
        return null;
      }

      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // finally, let's sign in
      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      return authResult.user;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error during Google sign in: $e');
      return null;
    }
  }
}
