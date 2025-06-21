import 'package:bloc_ecommerce/src/data/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> fetchUserData() async {
    try {
      final userData = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      debugPrint('User data: ${userData.data()}');
      if (userData.data() != null) {
        final user = UserModel.fromJson(userData.data()!);
        return user;
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      throw Exception(e);
    } finally {}
  }
}
