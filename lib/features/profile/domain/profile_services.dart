import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserName(String uid, String newName) async {
    await _db.collection('user').doc(uid).update({'name' : newName});
  }

}