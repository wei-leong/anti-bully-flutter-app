import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/admin/admin_dashboard/ui/widgets/escalation_tile.dart';
import 'package:apu_assignment/features/admin/admin_dashboard/ui/widgets/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            _buildSectionHeader(context, "System Overview", false, null),
            kGap8,
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: "Active Cases",
                    value: "24",
                    icon: Icons.folder_open_rounded,
                    color: Colors.orange,
                  ),
                ),
                const Gap(kSmallPadding),
                Expanded(
                  child: StatsCard(
                    title: "Pending Staff",
                    value: "05",
                    icon: Icons.person_add_alt_1_rounded,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            kGap8,
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: "Articles",
                    value: "108",
                    icon: Icons.article_rounded,
                    color: Colors.purple,
                  ),
                ),
                const Gap(kSmallPadding),
                Expanded(
                  child: StatsCard(
                    title: "Total Reports",
                    value: "1.2k",
                    icon: Icons.bar_chart_rounded,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            _buildSectionHeader(context, "Recent Escalations", true, () {}),
            kGap8,
            EscalationTile(caseId: "Case #2024-099", incidentType: "Physical Bullying" ,reason: "Unresolved for 48h", severity: "CRITICAL"),
            EscalationTile(caseId: "Case #2024-199", incidentType: "Cyber Bullying ", reason: "Flagged by Counselor", severity: "HIGH"),
          ],
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
