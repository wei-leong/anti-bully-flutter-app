import 'package:apu_assignment/features/profile/domain/profile_repository.dart';
import 'package:apu_assignment/features/profile/domain/profile_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileServiceProvider = Provider<ProfileServices>((ref){
  return ProfileServices();
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref){
  final service = ref.watch(profileServiceProvider);
  return ProfileRepository(service);
});