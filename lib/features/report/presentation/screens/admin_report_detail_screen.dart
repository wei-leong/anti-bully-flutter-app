import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:apu_assignment/features/report/presentation/widgets/admin_incident_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdminReportDetailScreen extends ConsumerWidget {
  final ReportModel report;

  const AdminReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final formattedDate = DateFormat(
      'MMM dd, yyyy • HH:mm a',
    ).format(report.incidentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Case #${report.id?.substring(0, 8) ?? 'Unknown'}",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Incident Overview"),
            AdminIncidentListTile(
              title: "Category",
              description: "${report.reportType.name[0].toUpperCase()}${report.reportType.name.substring(1)} Bullying",
              icon: Icons.category,
            ),
            AdminIncidentListTile(
              title: "Date/Time",
              description: formattedDate,
              icon: Icons.calendar_month,
            ),
            AdminIncidentListTile(
              title: "Location",
              description: report.location,
              icon: Icons.map,
            ),
            AdminIncidentListTile(
              title: "Reporter",
              description: "Anonymous (Student)",
              icon: Icons.person,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.message, color: colorScheme.primary),
              title: Text(
                "Description",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              report.description,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            kGap16,
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.person_add, color: colorScheme.primary),
              title: Text(
                "Assign Counselor",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: kDefaultPadding,
          vertical: kOnboardContentPadding,
        ),
        child: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text("Assign Counselor"),
        ),
      ),
    );
  }
}
