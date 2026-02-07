import 'package:apu_assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:apu_assignment/features/users/dashboard/presentation/screens/dashboard_screen.dart';
// TODO: Import your specific Admin screens here when ready
import 'package:flutter/material.dart';

class MainWrapperAdmin extends StatefulWidget { 
  const MainWrapperAdmin({super.key});

  @override
  State<MainWrapperAdmin> createState() => _MainWrapperAdminState();
}

class _MainWrapperAdminState extends State<MainWrapperAdmin> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),             // Home (Admin Dashboard)
    const Center(child: Text("Manage Reports")),    // TODO : Report (Placeholder)
    const Center(child: Text("Manage Community")),  // TODO : Community (Placeholder)
    const Center(child: Text("Manage Staff")),      // TODO : Staff (Placeholder)
    const ProfileScreen(),               // Profile (Settings)
  ];

  @override
  Widget build(BuildContext context) {
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
          // 2. REPORT
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment_rounded),
            label: "Report",
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