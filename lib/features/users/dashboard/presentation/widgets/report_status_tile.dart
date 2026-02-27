import 'package:intl/intl.dart';
import 'package:apu_assignment/features/users/report/model/report_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReportStatusTile extends StatelessWidget {
  final ReportModel report; // Accepts the Model object

  const ReportStatusTile({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Access style data directly from the Enum in the model
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch(report.reportStatus){
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
    final String displayType = "${reportTypeString[0].toUpperCase()}${reportTypeString.substring(1)} Incident";
    final String displayDate = DateFormat('MMM dd, yyyy').format(report.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          // 1. LEADING ICON BOX
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 24,
            ),
          ),
          
          const Gap(16),

          // 2. TITLE & DATE
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

          // 3. STATUS BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
    );
  }
}