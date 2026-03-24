import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/users/dashboard/presentation/widgets/report_status_tile.dart';
import 'package:apu_assignment/features/report/data/report_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportHistoryScreen extends ConsumerWidget {
  const ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsyncValue = ref.watch(userReportsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports History"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
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
                  return ListView.builder(
                    shrinkWrap: true, // Crucial when inside a SingleChildScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables inner scrolling
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      // Pass the fetched model into your beautifully styled widget!
                      return ReportStatusTile(report: reports[index]);
                    },
                  );
                },
                error: (error, stack) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Center(child: Text('Error loading reports: $error')),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
