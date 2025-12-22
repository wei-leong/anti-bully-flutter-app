import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/presentation/login/ui/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _passwordController = TextEditingController();
  String selectedRole = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      kGap8,
                      Text("Sign up to get started"),
                      kGap16,
                      SegmentedButton<String>(
                        segments: const <ButtonSegment<String>>[
                          ButtonSegment(
                            value: "Student",
                            label: Text("Student"),
                          ),
                          ButtonSegment(
                            value: "Lecturer",
                            label: Text("Lecturer"),
                          ),
                        ],
                        style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        selected: <String>{selectedRole},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            selectedRole = newSelection.first;
                          });
                        },
                      ),
                      kGap16,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (value.endsWith("@gmail.com") == false) {
                            return "Please enter email that ends with @gmail.com";
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      kGap16,
                      TextFormField(
                        obscuringCharacter: "*",
                        obscureText: !_isPasswordVisible,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible == false
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      kGap16,
                      TextFormField(
                        obscuringCharacter: "*",
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible == false
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          } else if (value != _passwordController.text) {
                            return "Passwords doesn't match";
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      kGap16,
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Business Logic: Save to Floor DB via ViewModel
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Text("Sign Up"),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
