import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/conselor/user_list/model/user_list_repository.dart';
import 'package:apu_assignment/features/conselor/user_list/model/user_list_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListServiceProvider = Provider<UserListServices>((ref){
  return UserListServices();
});

final userListRepositoryProvider = Provider<UserListRepository>((ref){
  final service = ref.watch(userListServiceProvider);
  return UserListRepository(service);
});

final userListStreamProvider = StreamProvider.autoDispose<List<UserModel>>((ref){
  final repository = ref.watch(userListRepositoryProvider);

  return repository.getAllUser();
});