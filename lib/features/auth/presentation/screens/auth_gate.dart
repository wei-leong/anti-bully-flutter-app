import 'package:apu_assignment/core/navigation/main_wrapper_admin.dart';
import 'package:apu_assignment/core/navigation/main_wrapper_user.dart';
import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/presentation/screens/role_select_screen.dart';
import 'package:apu_assignment/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (firebaseUser) {
        // Case 1 : Not logged in to Firebase
        if (firebaseUser == null) {
          return SignInScreen(providers: [EmailAuthProvider()]);
        }

        // Case 2 : Logged Into Firebase and Now Watch for Firestore Data
        final userModelAsync = ref.watch(userModelProvider);

        return userModelAsync.when(
          data: (userModel){
            // Case 3: Logged in, but no Firestore document exists yet
            if (userModel == null) {
              return const RoleSelectScreen();
            }

            // Case 4: Logged in AND has a role
            switch (userModel.role) {
              case UserRole.user:
                return const MainWrapperUser();
              case UserRole.counselor:
                // TODO: Remove This Later
                return Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        icon: Icon(Icons.logout),
                      ),
                    ],
                  ),
                  body: const Center(child: Text("Counselor Page")),
                );
              case UserRole.admin:
                return const MainWrapperAdmin();
              default:
                return const RoleSelectScreen();
            }
          },
          error: (error, stack) =>
              Scaffold(body: Center(child: Text("DB Error: $error"))),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
      error: (error, stack) =>
          Scaffold(body: Center(child: Text("Error : $error"))),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
