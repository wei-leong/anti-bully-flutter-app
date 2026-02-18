import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import "package:apu_assignment/features/conselor/dashboard/report/report.dart";

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    // --- MOCK DATA : REPORTS ---
  final List<Map<String, dynamic>> mockReports = [
    {
      "location": "Library Hall A",
      "date": "Jan 12, 2026",
      "description": "Student reported verbal harassment near the entrance.",
      "status": "In-progress",
      "Level": 3
    },
    {
      "location": "Cafeteria",
      "date": "Jan 11, 2026",
      "description": "Anonymity case: Victim fears retaliation after a group incident.",
      "status": "Pending",
      "Level": 3
    },
  ];

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(child: Icon(Icons.person)),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  "Alex Johnson",
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.error,
            ),
            icon: Icon(Icons.sos_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assigned Reports", // Heading
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            ...mockReports.map((data) => ReportCard(
              location: data['location']!,
              date: data['date']!,
              description: data['description']!,
              status: data['status']!,
              urgentlevel: data['level'],
              onTap: () {
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
  }