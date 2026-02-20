import 'dart:async';

import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roleSelectionViewModelProvider =
    AsyncNotifierProvider<RoleSelectionViewModel, void>(RoleSelectionViewModel.new);

class RoleSelectionViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> selectRole(UserRole role, String name) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async { // Direct to MainWrapper page after selected Role and input Name
      final auth = ref.read(firebaseAuthProvider);
      final repository = ref.read(userRepositoryProvider);

      final currentUser = auth.currentUser;
      if (currentUser == null) throw Exception("No user logged in");

      final newUser = UserModel(
        uid: currentUser.uid,
        name: name,
        email: currentUser.email ?? '',
        role: role,
        createdAt: DateTime.now(),
      );

      await repository.saveUserData(newUser);
    });
  }
}
