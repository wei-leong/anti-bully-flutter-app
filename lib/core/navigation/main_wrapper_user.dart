import 'package:apu_assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainWrapperUser extends StatefulWidget {
  const MainWrapperUser({super.key});

  @override
  State<MainWrapperUser> createState() => _MainWrapperUserState();
}

class _MainWrapperUserState extends State<MainWrapperUser> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text("Home")), // TODO: Home Page
    const Center(child: Text("Resources")), // TODO: Resources Page
    const Center(child: Text("Chat")), // TODO : Chat Page
    const ProfileScreen(), // TODO : Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    final double textFontSize = 14;

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
