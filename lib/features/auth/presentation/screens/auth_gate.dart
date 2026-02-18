import 'package:apu_assignment/core/navigation/main_wrapper_admin.dart';
import 'package:apu_assignment/core/navigation/main_wrapper_user.dart';
import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/model/user_repository.dart';
import 'package:apu_assignment/features/auth/presentation/screens/role_select_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        // Loading
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (authSnapshot.hasData) {
          final firebaseUser = authSnapshot.data!;

          return FutureBuilder<bool>(
            future: UserRepository().isUserExist(firebaseUser.uid),
            builder: (context, existSnapshot) {
              if (existSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (existSnapshot.hasData && existSnapshot.data == true) {
                return FutureBuilder<UserModel?>(
                  future: UserRepository().getUser(firebaseUser.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    } 
                    
                    if(snapshot.hasData){
                      final userModel = snapshot.data!;

                      // Navigate based on Role
                      switch (userModel.role) {
                        case UserRole.user:
                          return const MainWrapperUser();
                        case UserRole.counselor:
                          // Assuming ProfileScreen doesn't take arguments
                          return const ProfileScreen(); 
                        case UserRole.admin:
                          return const MainWrapperAdmin();
                        default:
                          return const RoleSelectScreen();
                      }
                    }
                    else {
                      return const RoleSelectScreen();
                    }
                  },
                );
              } else {
                return const RoleSelectScreen();
              }
            },
          );
        } else {
          return SignInScreen(providers: [EmailAuthProvider()]);
        }
      },
    );
  }
}
