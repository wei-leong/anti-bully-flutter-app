import 'package:apu_assignment/features/conselor/dashboard/presentation/widgets/quick_access.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import "package:apu_assignment/features/conselor/dashboard/presentation/widgets/report.dart";
import "package:apu_assignment/features/conselor/dashboard/presentation/widgets/view_details.dart";
import 'package:apu_assignment/features/conselor/dashboard/presentation/viewmodels/report_viewmodel.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(reportProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(child: Icon(Icons.person)),
            const Gap(12),
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
                  "Iris",
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
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.error,
            ),
            icon: Icon(Icons.sos_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Access",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )
            ),
            const Gap(16),
            
            QuickAccess(),

            const Gap(16),
            Text(
              "Cases Reports", // Heading
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const Gap(16),

            reportAsync.when(
              // 数据加载成功
              data: (reports) => Column(
                children: reports.map((report) => ReportCard(
                  location: report.location,
                  date: report.date,
                  description: report.description,
                  status: report.status,
                  urgentlevel: report.urgentLevel,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.85,
                        // 这里传入 report 对象，ViewDetails 内部也要改成接收 ReportModel
                        child: ViewDetails(report: report), 
                      ),
                    );
                  },
                )).toList(),
              ),
              // 加载中显示的 UI
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              // 出错时显示的 UI
              error: (err, stack) => Center(
                child: Text("Failed to load reports: $err"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}