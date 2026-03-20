import 'package:apu_assignment/features/conselor/dashboard/presentation/viewmodels/report_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:apu_assignment/features/conselor/dashboard/model/report_model.dart';

class ViewDetails extends ConsumerWidget {
  final ReportModel report;
  const ViewDetails({super.key, required this.report});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Use for checking updated status
    ref.listen<AsyncValue<void>>(reportViewModelProvider, (prev, next) {
      next.whenOrNull(
        error: (err, _) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $err"))),
        data: (_) { if (prev is AsyncLoading) Navigator.pop(context); },
      );
    });
    final updateState = ref.watch(reportViewModelProvider);

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
                  _buildInfoSection("Report Type", report.type, Icons.book, Colors.lightBlueAccent),
                  const Gap(24),
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
                      onPressed: updateState.isLoading ? null : () => _showStatusPicker(context, ref),
                      icon: const Icon(Icons.edit_note),
                      label: Text("Update Status"),
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

  void _showStatusPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.recycling, color: Colors.blue),
              title: const Text("In-progress"),
              onTap: () {
                ref.read(reportViewModelProvider.notifier).updateStatus(report.id, "In-progress");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.green),
              title: const Text("End"),
              onTap: () {
                ref.read(reportViewModelProvider.notifier).updateStatus(report.id, "End");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
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
