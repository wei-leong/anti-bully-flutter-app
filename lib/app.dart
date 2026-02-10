import 'package:apu_assignment/core/theme/theme.dart';
import 'package:apu_assignment/core/theme/util.dart';
import 'package:apu_assignment/features/auth/presentation/screens/auth_gate.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: AuthGate(),
    );
  }
}
