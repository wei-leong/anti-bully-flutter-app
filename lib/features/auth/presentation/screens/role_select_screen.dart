import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:apu_assignment/features/auth/presentation/viewmodels/role_selection_viewmodel.dart';
import 'package:apu_assignment/features/auth/presentation/widgets/role_selection_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleSelectScreen extends ConsumerStatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  ConsumerState<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends ConsumerState<RoleSelectScreen> {
  final TextEditingController _nameController = TextEditingController();
  UserRole selectedRole = UserRole.user;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final name = _nameController.text;
    final role = selectedRole;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name first. ")),
      );
      return;
    }

    ref.read(roleSelectionViewModelProvider.notifier).selectRole(role, name);
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    ref.listen(roleSelectionViewModelProvider, (previous, next) {
      if(!next.isLoading && next.hasError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }

      else if (!next.isLoading && previous?.isLoading == true && !next.hasError) {
        // Just tell the AuthGate to refresh. It will automatically route you to MainWrapperUser.
        ref.invalidate(userModelProvider); 
      }
    });

    final isLoading = ref.watch(roleSelectionViewModelProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Complete Your Profile",
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              kGap8,
              Text(
                "Let's get to know you better to keep our community safe and personalized.",
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              kGap16,
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "John Smith",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                ),
              ),
              kGap16,
              Text("Select Your Role"),
              kGap8,
              Row(
                children: [
                  Expanded(
                    child: RoleSelectionCards(
                      label: "User",
                      icon: Icons.person,
                      isSelected: selectedRole == UserRole.user,
                      onTap: () =>
                          setState(() => selectedRole = UserRole.user),
                    ),
                  ),
                  kGap8,
                  Expanded(
                    child: RoleSelectionCards(
                      label: "Counselor",
                      icon: Icons.health_and_safety_outlined,
                      isSelected: selectedRole == UserRole.counselor,
                      onTap: () =>
                          setState(() => selectedRole = UserRole.counselor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          kDefaultPadding,
          0,
          kDefaultPadding,
          50,
        ),
        child: SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: _onSubmit,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Text("Get Started"),
          ),
        ),
      ),
    );
  }
}
