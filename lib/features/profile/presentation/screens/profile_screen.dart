import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/theme_selector_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            onPressed: () {},
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
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300',
                      ), // TODO: Change the Background Image
                    ),
                    // Change Profile Picture Icon
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: colorScheme.primary),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: colorScheme.onPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Text(
                  "Tan Jia Jie",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  "User",
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? 'Error', // TODO : Modify it to Use Email Address in Users Table
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
                onTap: () {},
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
