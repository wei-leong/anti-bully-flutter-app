import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserName(String uid, String newName) async {
    await _db.collection('user').doc(uid).update({'name': newName});
  }

  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    } else {
      throw Exception("No authenticated user found.");
    }
  }

  Future<void> deleteAccount(String uid) async {
    final user = _auth.currentUser;
    if (user != null) {
      // 1. Delete user data from Firestore first
      await _db.collection('user').doc(uid).delete();
      
      // 2. Delete the account from Firebase Authentication
      await user.delete();
    } else {
      throw Exception("No authenticated user found.");
    }
  }
}
