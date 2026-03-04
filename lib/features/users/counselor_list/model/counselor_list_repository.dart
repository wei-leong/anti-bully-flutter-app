import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/users/counselor_list/model/counselor_list_services.dart';

class CounselorListRepository {
  final CounselorListServices counselorListServices ;

  CounselorListRepository(this.counselorListServices);

  Stream<List<UserModel>> getAllCounselor() {
    try {
      return counselorListServices.getCounselorList();
    } catch (e){
      throw Exception('Failed to Get Counselor: $e');
    }
  }
}