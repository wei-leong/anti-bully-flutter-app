import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:apu_assignment/features/report/presentation/widgets/incident_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UserReportDetailScreen extends ConsumerStatefulWidget {
  final ReportModel report;

  const UserReportDetailScreen({super.key, required this.report});

  @override
  ConsumerState<UserReportDetailScreen> createState() =>
      UserReportDetailScreenState();
}

class UserReportDetailScreenState
    extends ConsumerState<UserReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final formattedDate = DateFormat(
      'MMM dd, yyyy • HH:mm a',
    ).format(widget.report.incidentDate);

    return Scaffold(
      appBar: AppBar(title: Text("Report Detail")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Incident Overview"),
            IncidentListTile(
              title: "Category",
              description:
                  "${widget.report.reportType.name[0].toUpperCase()}${widget.report.reportType.name.substring(1)} Bullying",
              icon: Icons.category,
            ),
            IncidentListTile(
              title: "Date/Time",
              description: formattedDate,
              icon: Icons.calendar_month,
            ),
            IncidentListTile(
              title: "Location",
              description: widget.report.location,
              icon: Icons.map,
            ),
            IncidentListTile(
              title: "Reporter",
              description: "Anonymous (Student)",
              icon: Icons.person,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.message, color: colorScheme.primary),
              ),
              title: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            kGap8,
            Text(
              widget.report.description,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
