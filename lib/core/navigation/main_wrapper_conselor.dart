import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_list_screens.dart';
import 'package:apu_assignment/features/conselor/dashboard/presentation/screens/dashboard.dart';
import 'package:apu_assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:apu_assignment/features/resources/presentation/screens/resources_screen.dart';
import 'package:apu_assignment/features/conselor/post/presentation/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWrapperConselor extends ConsumerStatefulWidget {
  const MainWrapperConselor({super.key});

  @override
  ConsumerState<MainWrapperConselor> createState() => _MainWrapperUserState();
}

class _MainWrapperUserState extends ConsumerState<MainWrapperConselor> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double textFontSize = 14;
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUserUid = firebaseAuth.currentUser?.uid ?? '';

    final List<Widget> _screens = [
      const Dashboard(), // TODO: Home Page
      const ResourceScreen(), // Resources Page
      const PostScreen(),
      ChatListScreens(userUid: currentUserUid,isCounselor: true), // Chat Page
      const ProfileScreen(), // Profile Page
    ];

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
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: "Post",
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
