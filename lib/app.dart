import 'package:apu_assignment/core/theme/theme.dart';
import 'package:apu_assignment/core/theme/util.dart';
import 'package:apu_assignment/features/auth/presentation/screens/auth_gate.dart';
import 'package:apu_assignment/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:apu_assignment/features/profile/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key, required this.screens});

  final Widget screens;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: currentTheme,
      home: screens,
    );
  }
}
