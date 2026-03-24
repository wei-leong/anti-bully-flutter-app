import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/conselor/user_list/model/user_list_services.dart';

class UserListRepository {
  final UserListServices userListServices ;

  UserListRepository(this.userListServices);

  Stream<List<UserModel>> getAllUser() {
    try {
      return userListServices.getUserList();
    } catch (e){
      throw Exception('Failed to Get Counselor: $e');
    }
  }
}