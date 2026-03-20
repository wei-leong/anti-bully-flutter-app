import 'package:apu_assignment/features/admin/admin_dashboard/ui/screens/admin_dashboard_screen.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_list_screens.dart';
import 'package:apu_assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWrapperAdmin extends ConsumerStatefulWidget {
  const MainWrapperAdmin({super.key});

  @override
  ConsumerState<MainWrapperAdmin> createState() => _MainWrapperAdminState();
}

class _MainWrapperAdminState extends ConsumerState<MainWrapperAdmin> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUserUid = firebaseAuth.currentUser?.uid ?? '';

    final List<Widget> _screens = [
      const AdminDashboardScreen(), // Home (Admin Dashboard)
      const Center(
        child: Text("Manage Community"),
      ), // TODO : Community (Placeholder)
      const Center(child: Text("Manage Staff")), // TODO : Staff (Placeholder)
      ChatListScreens(userUid: currentUserUid),
      const ProfileScreen(), // Profile (Settings)
    ];

    final colorScheme = Theme.of(context).colorScheme;
    const double textFontSize = 12;
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.outline,
        selectedFontSize: textFontSize,
        unselectedFontSize: textFontSize,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const [
          // 1. HOME
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: "Home",
          ),
          // 3. COMMUNITY
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people_alt_rounded),
            label: "Community",
          ),
          // 4. STAFF
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            activeIcon: Icon(Icons.badge_rounded),
            label: "Staff",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat),
            label: "Chat",
          ),
          // 5. PROFILE (SETTINGS)
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
