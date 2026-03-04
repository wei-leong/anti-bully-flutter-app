import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/users/counselor_list/model/counselor_list_repository.dart';
import 'package:apu_assignment/features/users/counselor_list/model/counselor_list_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counselorListServiceProvider = Provider<CounselorListServices>((ref){
  return CounselorListServices();
});

final counselorListRepositoryProvider = Provider<CounselorListRepository>((ref){
  final service = ref.watch(counselorListServiceProvider);
  return CounselorListRepository(service);
});

final counselorListStreamProvider = StreamProvider.autoDispose<List<UserModel>>((ref){
  final repository = ref.watch(counselorListRepositoryProvider);

  return repository.getAllCounselor();
});