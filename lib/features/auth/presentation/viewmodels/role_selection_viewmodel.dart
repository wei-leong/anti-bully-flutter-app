import 'dart:async';

import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/model/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roleSelectionVideModelProvider = 
    AsyncNotifierProvider<RoleSelectionViewModel, void>(RoleSelectionViewModel.new);

class RoleSelectionViewModel extends AsyncNotifier<void>{
  @override
  FutureOr<void> build(){

  }

  Future<void> selectRole(UserRole role, String name) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) throw Exception("No user logged in");

      final newUser = UserModel(
        uid: currentUser.uid,
        name: name,
        email: currentUser.email ?? '',
        role: role,
        createdAt: DateTime.now(),
      );
      final repository = UserRepository();
      await repository.saveUserData(newUser);
    });
  }
}