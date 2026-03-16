import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:apu_assignment/features/profile/presentation/screens/help_support_page.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/edit_profile_img.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/theme_selector_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final userNameAsyncValue = ref.watch(userNameProvider(currentUserUid));

    // Get Name and Role
    final currentName = userNameAsyncValue.when(
      data: (user) => user?.name ?? "User",
      error: (error, stackTrace) => "User",
      loading: () => "Loading...",
    );

    final currentRole = userNameAsyncValue.when(
      data: (user) {
        if (user == null) return "Unknown";
        final roleString = user.role.name;
        // Capitalize the first letter, keep the rest as is
        return "${roleString[0].toUpperCase()}${roleString.substring(1)}";
      },
      error: (error, stackTrace) => "Unknown",
      loading: () => "Loading...",
    );

    final currentEmail = userNameAsyncValue.when(
      data: (user) => user?.email ?? "Unknown",
      error: (error, stackTrace) => "Unknown",
      loading: () => "Loading...",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  currentName: currentName,
                  currentRole: currentRole,
                ),
              ),
            ),
            child: const Text(
              "Edit Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Column(
              children: [
                EditProfileImg(),
                const Gap(12),
                Text(
                  currentName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  currentRole,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                Text(
                  currentEmail,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const Gap(24),
            _buildSectionHeader("GENERAL"),
            _buildMenuContainer([
              ThemeSelectorCard(),
              ProfileMenuTile(
                title: "Notifications",
                icon: Icons.notifications,
                onTap: () {}, // Switch handles the tap usually
                trailing: Switch(
                  value: _notificationsEnabled,
                  // activeColor: const Color(0xFF0D8ACD),
                  onChanged: (val) =>
                      setState(() => _notificationsEnabled = val),
                ),
              ),
              ProfileMenuTile(
                title: "Help & Support",
                icon: Icons.help_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpSupportPage()),
                  );
                },
              ),
              ProfileMenuTile(
                title: "Privacy Policy",
                icon: Icons.lock_outline,
                onTap: () {},
              ),
            ]),
            const Gap(32),
            // Log Out Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colorScheme.errorContainer),
                  backgroundColor: colorScheme.errorContainer,
                ),
                icon: Icon(Icons.logout, color: colorScheme.error),
                label: Text(
                  "Log Out",
                  style: TextStyle(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  // Helper to group items in a white rounded container
  Widget _buildMenuContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
