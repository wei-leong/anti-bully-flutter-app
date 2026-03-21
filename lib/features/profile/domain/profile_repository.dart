import 'package:apu_assignment/features/profile/domain/profile_services.dart';

class ProfileRepository {

  final ProfileServices profileServices;

  ProfileRepository(this.profileServices);

  Future<void> saveUserData(String uid, String newName) async {
    try{
      await profileServices.saveUserName(uid, newName);
    } catch (e){
      throw Exception('Failed to Save User Data: $e');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await profileServices.changePassword(newPassword);
    } catch (e) {
      throw Exception('Failed to Update Password: $e');
    }
  }
}