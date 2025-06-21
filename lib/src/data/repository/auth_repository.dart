import 'package:bloc_ecommerce/src/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      // debugPrint('User: ${authResult.user?.email}');

      if(authResult.user != null){
        await createUserInDatabase(authResult.user!);
      }
      return authResult.user;
    } catch (error) {
      debugPrint("Error signing in with Google: $error");
      return null;
    }
  }

  Future<void> signInWithFacebook() async {}
  Future<void> signInWithTwitter() async {}

  Future<void> createUserInDatabase(User user) async {
    final data = UserModel(
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
    await _firestore.collection('users').doc(user.uid).set(data.toJson()).then((value){
      debugPrint('User created in firebase database: ${user.email}');
    });
    debugPrint('Creating user in database: ${user.email}');
  }
}
