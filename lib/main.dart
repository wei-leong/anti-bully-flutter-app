import 'package:apu_assignment/app.dart';
import 'package:apu_assignment/core/data/shared_pref_provider.dart';
import 'package:apu_assignment/features/auth/presentation/screens/auth_gate.dart';
import 'package:apu_assignment/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:apu_assignment/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // We must initialize Firebase before we can use it in the background
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: App(
        screens: seenOnboarding ? const AuthGate() : const OnboardingScreen(),
      ),
    ),
    // App(screens: RoleSelectScreen()), - For Testing Purposes
  );
}
