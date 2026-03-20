import 'package:apu_assignment/features/auth/data/auth_providers.dart';
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
    final auth = ref.read(firebaseAuthProvider);
    final currentUser = auth.currentUser;
    final userNameAsyncValue = ref.read(userNameProvider(currentUser!.uid));
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
                  userNameAsyncValue.when(
                    data: (user) => user?.name ?? '',
                    error: (error, stack) => "Counselor",
                    loading: () => "Counselor",
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
              data: (reports) {
                if (reports.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_turned_in_outlined,
                            size: 64,
                            color: colorScheme.outline.withOpacity(0.5),
                          ),
                          const Gap(16),
                          Text(
                            "No case reports found",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            "You are free now!",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                  return Column(
                  children: reports.map((report) => ReportCard(
                    location: report.location,
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
                          child: ViewDetails(report: report), 
                        ),
                      );
                    },
                  )).toList(),
                );
              },
    
              // UI
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              // Failed
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