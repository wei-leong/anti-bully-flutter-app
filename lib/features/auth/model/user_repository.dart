import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/model/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {

  final UserServices userServices;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserRepository(this.userServices);

  Future<void> saveUserData(UserModel user) async {
    try{
      await userServices.saveUserData(user.uid, user.toMap());
    } catch (e){
      throw Exception('Failed to Save User Data: $e');
    }
  }

  Future<bool> isUserExist(String uid) {
    return userServices.checkUserExist(uid);
  }

  Future<void> updateUserAccountStatus(String uid, String newStatus) async {
    try{
      await userServices.updateUserAccountStatus(uid, newStatus);
    } catch (e){
      throw Exception('Failed to Save User Data: $e');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try{
      DocumentSnapshot doc = await userServices.getUserData(uid);
      if(!doc.exists) return null;

      return UserModel.fromMap(doc.data() as Map<String,dynamic>, uid);
    } catch (e){
      // print("Error fetching user : $e");
      return null;
    }
  }
}