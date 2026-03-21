import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/resources/data/user_resources_provider.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:apu_assignment/features/users/counselor_list/presentation/screens/counselor_list_screen.dart';
import 'package:apu_assignment/features/users/dashboard/presentation/widgets/report_status_tile.dart';
import 'package:apu_assignment/features/report/data/report_providers.dart';
import 'package:apu_assignment/features/report/presentation/screens/report_history_screen.dart';
import 'package:apu_assignment/features/report/presentation/screens/report_incident_screen.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/news_or_event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsyncValue = ref.watch(userReportsProvider);

    final auth = ref.read(firebaseAuthProvider);
    final currentUser = auth.currentUser;
    final userNameAsyncValue = ref.watch(userNameProvider(currentUser!.uid));

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ProfileScreen()),
            //     );
            //   },
            //   child: CircleAvatar(child: Icon(Icons.person)),
            // ),
            // const Gap(12),
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
                  userNameAsyncValue.when(
                    data: (user) => user?.name ?? '',
                    error: (error, stack) => "User",
                    loading: () => "User",
                  ),
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
                          // ? Navigate to Report Incident page
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
                        // ? Navigate to Counselor List Page for Chat
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CounselorListScreen(),
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
              _buildSectionHeader(
                context,
                "My Reports",
                true,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReportHistoryScreen(), // ? Navigate to Report History page
                  ),
                ),
              ),
              reportsAsyncValue.when(
                data: (reports) {
                  if (reports.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                      ),
                      child: Center(
                        child: Text(
                          "You haven't submitted any reports yet.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }

                  final recentReports = reports.take(3).toList();

                  return ListView.builder(
                    shrinkWrap:
                        true, // Crucial when inside a SingleChildScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables inner scrolling
                    itemCount: recentReports.length,
                    itemBuilder: (context, index) {
                      // Pass the fetched model into your beautifully styled widget!
                      return ReportStatusTile(report: recentReports[index]);
                    },
                  );
                },
                error: (error, stack) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  child: Center(child: Text('Error loading reports: $error')),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              _buildSectionHeader(context, "Community News", true, () {}),
              ref.watch(liveResourcesStreamProvider).when(
                data: (resources) {
                  // Filter to ONLY show news or events, and grab the latest 3
                  final communityNews = resources.where(
                    (item) => item.type.toLowerCase() == 'news' || item.type.toLowerCase() == 'events'
                  ).take(3).toList();

                  if (communityNews.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("No community news available at the moment."),
                    );
                  }

                  return Column(
                    children: communityNews.map(
                      (newsItem) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: NewsOrEventTile(resourceItem: newsItem),
                      ),
                    ).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Error loading news: $error'),
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
