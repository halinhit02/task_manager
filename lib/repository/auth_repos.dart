import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thuc_tap_chuyen_nganh/util/app_constants.dart';

class AuthRepos {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // The OAuth client id of your app. This is required.
    clientId:
    '404910094346-e7hqnj14k7s4qt3hmj3c2k4diorui8v2.apps.googleusercontent.com',
  );

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuthentication =
        await googleAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication?.accessToken,
      idToken: googleAuthentication?.idToken,
    );
      var userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        return Future.error(AppConstants.maintainMode);
      } else {
        return Future.error(AppConstants.errorOccurred);
      }
    } catch (e) {
      print(e.toString());
      return Future.error(AppConstants.errorOccurred);
    }
  }

  Future<User?> signInWithEmailPassword(String name, String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error(AppConstants.weekPassword);
      } else if (e.code == 'user-not-found') {
        return Future.error(AppConstants.wrongEmailOrPass);
      } else if (e.code == 'invalid-email') {
        return Future.error(AppConstants.emailNotValid);
      } else if (e.code == 'wrong-password') {
        return Future.error(AppConstants.wrongEmailOrPass);
      }
    } catch (e) {
      print(e.toString());
      return Future.error(AppConstants.errorOccurred);
    }
    return null;
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error(AppConstants.weekPassword);
      } else if (e.code == 'email-already-in-use') {
        return Future.error(AppConstants.emailInUse);
      } else if (e.code == 'invalid-email') {
        return Future.error(AppConstants.emailNotValid);
      } else if (e.code == 'operation-not-allowed') {
        return Future.error(AppConstants.maintainMode);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return null;
  }
}
