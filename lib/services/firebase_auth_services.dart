
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'base_services/auth_base.dart';

class FirebaseAuthServices implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel?> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return firebaseUsertoUserModel(user);
    } catch (e) {
      if (kDebugMode) {
        print("CURRENT USER ERROR $e");
      }
      return null;
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try {
      UserCredential user = await _firebaseAuth.signInAnonymously();
      return firebaseUsertoUserModel(user.user);
    } catch (e) {
      if (kDebugMode) {
        print("ANONYM LOGIN ERROR $e");
      }
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("SIGN OUT ERROR $e");
      }
      return false;
    }
  }

  UserModel? firebaseUsertoUserModel(User? user, {String? userName}) {
    //userName = userName==""||userName==null ? "${user!.email!.split("@")[0].toLowerCase()}${1000+Random().nextInt(9000)}" : userName;
    userName ??= user!.displayName;
    if (user == null) {
      return null;
    }
    return UserModel(
        userId: user.uid.toString(), email: user.email, userName: userName);
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        UserCredential firebaseGoogleUser =
            await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );
        return firebaseUsertoUserModel(
          firebaseGoogleUser.user,
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return firebaseUsertoUserModel(user.user);
    } catch (e) {
      if (kDebugMode) {
        print("EMAIL LOGIN ERROR $e");
      }
      return null;
    }
  }

  @override
  Future<UserModel?> signUpWithEmail(
      String email, String password, String? userName) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return firebaseUsertoUserModel(user.user, userName: userName);
  }
}
