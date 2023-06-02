import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thuc_tap_chuyen_nganh/util/app_constants.dart';

import '../model/app_user.dart';

class AuthRepos {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRepos._();

  static final instance = AuthRepos._();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<bool> isAuthenticated() async {
    return _auth.currentUser != null;
  }

  Future<AppUser?> getCurrentUser() async {
    var user = _auth.currentUser;
    return getAppUser(user);
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuthentication =
          await googleAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication?.accessToken,
        idToken: googleAuthentication?.idToken,
      );
      var userCredential = await _auth.signInWithCredential(credential);
      return getAppUser(userCredential.user);
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

  Future<AppUser?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return getAppUser(credential.user);
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

  Future<AppUser?> signUp(
      String username, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(username);
      return getAppUser(credential.user);
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

  Future<AppUser?> getAppUser(User? user) async {
    if (user != null) {
      var appUser = AppUser(
          uid: user.uid,
          username: (user.displayName ?? user.email ?? '').split('@')[0],
          email: user.email ?? '',
          photoURL: user.photoURL ?? '');
      var providerProfile = user.providerData[0];
      appUser.username = providerProfile.displayName ?? appUser.username;
      appUser.email = providerProfile.email ?? appUser.email;
      appUser.photoURL = providerProfile.photoURL ?? appUser.photoURL;
      return appUser;
    } else {
      return null;
    }
  }

  Future updateUsername(String username) async {
    var user = _auth.currentUser;
    if (user == null) {
      return Future.error('Sign in again.');
    }
    return user.updateDisplayName(username);
    /*try {
      var result = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: user.email!, password: password));
      if (result.user != null) {
        await result.user!.updateDisplayName(username);
      }
    } catch (e) {
      return Future.error(e.toString());
    }*/
  }

  Future updatePassword(String oldPassword, String newPassword) async {
    var user = _auth.currentUser;
    if (user == null) {
      return Future.error('Sign in again.');
    }
    try {
      var result = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: user.email!, password: oldPassword));
      if (result.user != null) {
        await result.user!.updatePassword(newPassword);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> signOut() async {
    _googleSignIn.signOut();
    await _auth.signOut();
  }
}
