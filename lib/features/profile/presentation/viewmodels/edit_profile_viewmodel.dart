import 'dart:async';

import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/profile/data/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileViewModelProvider =
    AsyncNotifierProvider<EditProfileViewModel, void>(EditProfileViewModel.new);

class EditProfileViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> updateName(String newName) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final currentUid = ref.read(firebaseAuthProvider).currentUser!.uid;
      final repository = ref.read(profileRepositoryProvider);

      await repository.saveUserData(currentUid,newName);
      
      // Invalidate the userNameProvider to show the UI Update
      ref.invalidate(userNameProvider);
    });
  }

  Future<void> updatePassword(String newPassword) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(profileRepositoryProvider);
      await repository.updatePassword(newPassword);
    });
  }

  // Future<void> deleteAccount() async {
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final currentUid = ref.read(firebaseAuthProvider).currentUser!.uid;
  //     final repository = ref.read(profileRepositoryProvider);
  //     await repository.deleteAccount(currentUid);
  //   });
  // }
}
