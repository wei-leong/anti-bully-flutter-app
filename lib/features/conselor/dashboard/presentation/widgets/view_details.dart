import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:apu_assignment/features/conselor/dashboard/model/report_model.dart';

class ViewDetails extends StatelessWidget {
  final ReportModel report;
  const ViewDetails({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    // Status color
    final Color statusColor = report.status == "In-progress" ? Colors.blue : 
                              report.status == "End" ? Colors.green : report.status == "Pending" ? Colors.orange:Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const Gap(12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Description
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection("Location", report.location, Icons.location_on, Colors.redAccent),
                  const Gap(20),
                  _buildInfoSection("Date Reported", report.date, Icons.calendar_today, Colors.blue),
                  const Gap(20),
                  _buildInfoSection("Current Status", report.status, Icons.hourglass_bottom, statusColor),
                  const Gap(24),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const Gap(8),
                  Text(
                    report.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const Gap(40),
                  
                  // Updated status button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: () {
                        // 处理逻辑
                      },
                      icon: const Icon(Icons.edit_note),
                      label: const Text("Update Status"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Text Helper
  Widget _buildInfoSection(String title, String content, IconData icon, Color iconColor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start, 
    children: [
      Icon(icon, color: iconColor, size: 20),
      const Gap(12),
      Expanded( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                height: 1.3, 
              ),
            ),
          ],
        ),
      )
    ],
  );
}
}