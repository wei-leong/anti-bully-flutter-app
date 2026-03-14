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
            CircleAvatar(radius: 24, child: Icon(Icons.person)),
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
          ],
        ),
      ),
    );
  }
}
