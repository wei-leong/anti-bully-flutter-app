import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/users/report/presentation/viewmodel/report_incident_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:apu_assignment/features/users/report/model/report_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReportStatusTile extends ConsumerWidget {
  final ReportModel report;

  const ReportStatusTile({super.key, required this.report});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (report.reportStatus) {
      case ReportStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.inbox_outlined;
        statusText = "Pending";
        break;
      case ReportStatus.inProgress:
        statusColor = Colors.blue;
        statusIcon = Icons.sync;
        statusText = "In Progress";
        break;
      case ReportStatus.complete:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_outline;
        statusText = "Completed";
        break;
    }

    final String reportTypeString = report.reportType.name;
    final String displayType =
        "${reportTypeString[0].toUpperCase()}${reportTypeString.substring(1)} Incident";
    final String displayDate = DateFormat(
      'MMM dd, yyyy',
    ).format(report.incidentDate); // TODO : Check if Show Created At or Incident Date

    // 1. WRAP IN PADDING (Moves the gap OUTSIDE the Slidable)
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(
          report.id,
        ), // Always add a key when using Slidable in a list!
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25, // Prevents the button from stretching too wide
          // TODO : Solve Bug in the Full Swipe
          // dismissible: DismissiblePane(
          //   onDismissed: () {
          //     ref
          //         .read(reportIncidentViewModelProvider.notifier)
          //         .deleteReport(reportId: report.id!);
          //   },
          // ),
          children: [
            SlidableAction(
              onPressed: (context) {
                ref
                    .read(reportIncidentViewModelProvider.notifier)
                    .deleteReport(reportId: report.id!);
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              icon: Icons.delete_outline_rounded,
              borderRadius: BorderRadius.circular(kDefaultRadius),
              // borderRadius: const BorderRadius.only(
              //   topRight: Radius.circular(16),
              //   bottomRight: Radius.circular(16),
              // ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(statusIcon, color: statusColor, size: 24),
              ),

              const Gap(16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayType,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      displayDate,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.2)),
                ),
                child: Text(
                  statusText,
                  style: textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
