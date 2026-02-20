import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/model/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {

  final UserServices userServices;

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