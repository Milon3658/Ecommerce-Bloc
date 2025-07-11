import 'package:bloc_ecommerce/src/data/model/user_model.dart';
import 'package:bloc_ecommerce/src/data/preference/local_preference.dart';
import 'package:bloc_ecommerce/src/utils/asset_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();

      if (googleSignIn == null) {
        debugPrint("User canceled the signing process.");
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignIn.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      if (authResult.user != null) {
        await createUserInDatabase(
            authResult.user!, authResult.user?.displayName);
      }
      return authResult.user;
    } catch (error) {
      throw Exception('Failed to sign in with Google: $error');
    }
  }

  Future<void> signInWithFacebook() async {}

  Future<void> signInWithTwitter() async {}

  Future<User?> signUpWithEmail(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user != null) {
        await createUserInDatabase(user, userName);
      }
      return user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<User?> SignInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      LocalPreferences.setString('name', user?.displayName ?? '');
      LocalPreferences.setString('email', user?.email ?? '');
      LocalPreferences.setString(
          'photoUrl', user?.photoURL ?? AssetManager.APP_LOGO);
      LocalPreferences.setString('phoneNumber', user?.phoneNumber ?? '');
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createUserInDatabase(User user, String? userName) async {
    final data = UserModel(
      name: user.displayName ?? userName,
      email: user.email,
      photoUrl: user.photoURL,
    );
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(data.toJson())
        .then((value) {
      debugPrint('User created in firebase database: ${user.email}');
    });
    LocalPreferences.setString('name', user.displayName ?? userName ?? '');
    LocalPreferences.setString('email', user.email ?? '');
    LocalPreferences.setString(
        'photoUrl', user.photoURL ?? AssetManager.APP_LOGO);
    LocalPreferences.setString('phoneNumber', user.phoneNumber ?? '');
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
