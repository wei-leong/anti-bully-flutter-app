import 'package:apu_assignment/core/navigation/main_wrapper_admin.dart';
import 'package:apu_assignment/core/navigation/main_wrapper_user.dart';
import 'package:apu_assignment/core/theme/theme_black_white.dart';
import 'package:apu_assignment/core/theme/util.dart';
import 'package:apu_assignment/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: MainWrapperAdmin(),
    );
  }
}
