import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserData(UserModel user) async {
    try{
      await _db.collection('user').doc(user.uid).set(user.toMap());
    } catch (e){
      throw Exception('Failed to Save User Data: $e');
    }
  }

  Future<bool> isUserExist(String uid) async {
    DocumentSnapshot doc = await _db.collection('user').doc(uid).get();
    return doc.exists;
  }

  Future<UserModel?> getUser(String uid) async {
    try{
      DocumentSnapshot doc = await _db.collection('user').doc(uid).get();
      if(!doc.exists) return null;

      return UserModel.fromMap(doc.data() as Map<String,dynamic>, uid);
    } catch (e){
      print("Error fetching user : $e");
      return null;
    }
  }
}