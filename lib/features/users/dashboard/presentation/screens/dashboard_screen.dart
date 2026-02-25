import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/users/dashboard/data/report_model.dart';
import 'package:apu_assignment/features/users/dashboard/presentation/widgets/report_status_tile.dart';
import 'package:apu_assignment/features/users/report/presentation/screens/report_incident_screen.dart';
import 'package:apu_assignment/features/users/resources/data/resource_item.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/news_or_event_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // --- MOCK DATA : REPORTS ---
    final List<ReportModel> recentReports = [
      ReportModel(
        caseId: "Case #2024-001",
        date: "2 hours ago",
        status: ReportStatus.received, // Using Enum
      ),
      ReportModel(
        caseId: "Case #2024-055",
        date: "Jan 28, 2026",
        status: ReportStatus.inProgress, // Using Enum
      ),
      ReportModel(
        caseId: "Case #2024-015",
        date: "Jan 8, 2026",
        status: ReportStatus.resolved, // Using Enum
      ),
    ];

    // --- MOCK DATA: NEWS ---
    final List<ResourceItem> communityNews = [
      ResourceItem(
        title: "Kindness Week Workshop",
        subtitle: "Join us this Friday in the main hall",
        source: "Student Council",
        type: "EVENT",
        durationOrSize: "Fri, 10 AM",
        imageUrl: "https://picsum.photos/seed/workshop/400/200",
      ),
      ResourceItem(
        title: "5 Signs of Cyberbullying",
        subtitle: "Learn how to spot the invisible signs",
        source: "UNICEF",
        type: "News",
        durationOrSize: "5 min read",
        imageUrl: "https://picsum.photos/seed/bullying/400/200",
      ),
      ResourceItem(
        title: "5 Signs of Cyberbullying",
        subtitle: "Learn how to spot the invisible signs",
        source: "UNICEF",
        type: "News",
        durationOrSize: "5 min read",
        imageUrl: "https://picsum.photos/seed/bullying/400/200",
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, "Quick Actions", false, () {}),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: colorScheme.errorContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                        side: BorderSide(color: colorScheme.errorContainer),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportIncidentScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: colorScheme.error, // Bright Red Icon
                                size: 28,
                              ),
                              Text(
                                "Report Incident",
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Submit anonymously",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: colorScheme.outline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                      ),
                      child: InkWell(
                        onTap: () {
                          // TODO : Add backend logic
                        },
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons
                                    .support_agent_rounded, // Matches the Headset icon
                                color: colorScheme
                                    .onPrimaryContainer, // Text/Icon color
                                size: 28,
                              ),
                              Text(
                                "Get Help",
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                "Talk to a counselor",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: colorScheme.outline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _buildSectionHeader(context, "My Reports", true, () {}),
              ...recentReports.map(
                (reportItem) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ReportStatusTile(report: reportItem),
                ),
              ),
              _buildSectionHeader(context, "Community News", true, () {}),
              ...communityNews.map(
                (newsItem) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: NewsOrEventTile(resourceItem: newsItem),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    bool isSeeAllEnabled,
    VoidCallback? onPressed,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (isSeeAllEnabled)
          TextButton(
            onPressed: onPressed,
            child: Text(
              "See All",
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
