import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_list_screens.dart';
import 'package:apu_assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:apu_assignment/features/users/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:apu_assignment/features/users/resources/presentation/screens/resource_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Global Provider to Control Bottom Nav Index
final userBottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainWrapperUser extends ConsumerWidget {
  const MainWrapperUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(userBottomNavIndexProvider);

    final double textFontSize = 14;
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUserUid = firebaseAuth.currentUser?.uid ?? '';

    final List<Widget> screens = [
      const DashboardScreen(), // Home Page
      const ResourceScreen(), // Resources Page
      ChatListScreens(userUid: currentUserUid, isCounselor: false), // Chat Page
      const ProfileScreen(), // Profile Page
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(userBottomNavIndexProvider.notifier).state = index;
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textFontSize,
        unselectedFontSize: textFontSize,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: "Resources",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// data - repository
// domain -
// presentation - controller, screens, widgets
