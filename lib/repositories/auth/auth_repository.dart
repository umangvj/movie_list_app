import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_list/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:movie_list/models/models.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<User> get user => _firebaseAuth.userChanges();

  @override
  String username() {
    String name = _firebaseAuth.currentUser.displayName;
    return name.split(" ")[0];
  }

  @override
  Future<User> loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      auth.UserCredential authCredential =
          await _firebaseAuth.signInWithCredential(credential);

      auth.User user = authCredential.user;

      return user;
    } on auth.FirebaseException catch (err) {
      throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
