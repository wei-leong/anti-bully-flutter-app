import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/profile/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String currentName;
  final String currentRole;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentRole,
  });

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentName);
    _roleController = TextEditingController(text: widget.currentRole);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_nameController.text.isNotEmpty) {
                await ref
                    .read(editProfileViewModelProvider.notifier)
                    .updateName(_nameController.text);
                if (context.mounted)
                  Navigator.pop(context); // Go back after saving!
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 40)),
            const Gap(12),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
              ),
            ),
            kGap16,
            TextField(
              controller: _roleController,
              enabled: false,
              decoration: InputDecoration(
                labelText: "Role",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
              ),
            ),
            kGap16,
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.lock_outline, color: colorScheme.primary),
              title: const Text(
                "Change Password",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showChangePasswordDialog(context, ref),
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: Icon(Icons.lock_outline, color: colorScheme.primary),
            //   title: const Text(
            //     "Delete Account",
            //     style: TextStyle(fontWeight: FontWeight.w600),
            //   ),
            //   trailing: const Icon(Icons.chevron_right),
            //   onTap: () => _showDeleteAccountDialog(context, ref),
            // ),
          ],
        ),
      ),
    );
  }
}

void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
  final passwordController = TextEditingController();
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text("Change Password"),
      content: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "New Password",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () async {
            if (passwordController.text.length >= 6) {
              Navigator.pop(dialogContext); // Closes the dialog box

              await ref
                  .read(editProfileViewModelProvider.notifier)
                  .updatePassword(passwordController.text);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password updated successfully!"),
                  ),
                );

                // Closes the whole "Edit Profile" screen so they don't feel stuck!
                Navigator.pop(context);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password must be at least 6 characters."),
                ),
              );
            }
          },
          child: const Text("Update"),
        ),
      ],
    ),
  );
}

// void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Delete Account"),
//         content: const Text("Are you absolutely sure? This action cannot be undone and will permanently erase all your data."),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
//             onPressed: () async {
//               Navigator.pop(context); // Close dialog
//               await ref.read(editProfileViewModelProvider.notifier).deleteAccount();
//               // Note: Because AuthGate watches your Firebase Auth state, deleting the account 
//               // will automatically kick the user back to the LoginScreen!
//             },
//             child: const Text("Delete Forever"),
//           ),
//         ],
//       ),
//     );
//   }