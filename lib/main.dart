import 'package:apu_assignment/app.dart';
import 'package:apu_assignment/features/auth/presentation/screens/auth_gate.dart';
import 'package:apu_assignment/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:apu_assignment/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    App(screens: seenOnboarding ? const AuthGate() : const OnboardingScreen()),
  );
}
