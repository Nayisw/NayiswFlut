import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Google Sign In
class AuthService {
  signInWithGoogle() async {
    // Google interactive Sign In menu
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // Obtain auth credentials from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    // sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
