import 'package:apu_assignment/core/navigation/main_wrapper_user.dart';
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
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          final user = snapshot.data!;

          return FutureBuilder<bool>(
            future: UserRepository().isUserExist(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if(snapshot.data == true){
                return const MainWrapperUser();
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
