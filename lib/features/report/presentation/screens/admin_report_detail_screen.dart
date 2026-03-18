import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:apu_assignment/features/report/presentation/viewmodel/admin_report_viewmodel.dart';
import 'package:apu_assignment/features/report/presentation/widgets/admin_incident_list_tile.dart';
import 'package:apu_assignment/features/report/presentation/widgets/select_counselor_list_tile.dart';
import 'package:apu_assignment/features/users/counselor_list/data/counselor_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdminReportDetailScreen extends ConsumerStatefulWidget {
  final ReportModel report;

  const AdminReportDetailScreen({super.key, required this.report});

  @override
  ConsumerState<AdminReportDetailScreen> createState() =>
      _AdminReportDetailScreenState();
}

class _AdminReportDetailScreenState
    extends ConsumerState<AdminReportDetailScreen> {
  String? _selectedCounselorId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final counselorListAsync = ref.watch(counselorListStreamProvider);

    final formattedDate = DateFormat(
      'MMM dd, yyyy • HH:mm a',
    ).format(widget.report.incidentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Case #${widget.report.id?.substring(0, 8) ?? 'Unknown'}"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Incident Overview"),
            AdminIncidentListTile(
              title: "Category",
              description:
                  "${widget.report.reportType.name[0].toUpperCase()}${widget.report.reportType.name.substring(1)} Bullying",
              icon: Icons.category,
            ),
            AdminIncidentListTile(
              title: "Date/Time",
              description: formattedDate,
              icon: Icons.calendar_month,
            ),
            AdminIncidentListTile(
              title: "Location",
              description: widget.report.location,
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
              widget.report.description,
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
            counselorListAsync.when(
              data: (counselors) {
                if (counselors.isEmpty)
                  return const Center(child: Text("No counselors available."));

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: counselors.length,
                  itemBuilder: (context, index) {
                    final counselor = counselors[index];
                    final isSelected = _selectedCounselorId == counselor.uid;

                    return SelectCounselorListTile(
                      counselor: counselor,
                      isSelected: isSelected,
                      onTap: (){
                        setState(() {
                          _selectedCounselorId = counselor.uid;
                        });
                      },
                    );
                  },
                );
              },
              error: (error, stack) => Text("Error loading counselors: $error"),
              loading: () => const Center(child: CircularProgressIndicator()),
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
          // Button will be Disabled when the Counselor Id isn't defined
          onPressed: _selectedCounselorId == null
              ? null
              : () async {
                  // Call the ViewModel
                  await ref
                      .read(adminReportIncidentViewModelProvider.notifier)
                      .assignCounselor(
                        widget.report.id!,
                        _selectedCounselorId!,
                      );

                  // Show Success Message
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Counselor assigned successfully!"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text("Assign Counselor"),
        ),
      ),
    );
  }
}
