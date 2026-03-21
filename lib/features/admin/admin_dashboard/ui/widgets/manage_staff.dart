import 'package:apu_assignment/features/admin/admin_dashboard/ui/widgets/staff_details.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class staffmanagement extends ConsumerWidget {
  const staffmanagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingUsersAsync = ref.watch(pendingUsersProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Staff Approval", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: pendingUsersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text("No pending account requests"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(user.name[0].toUpperCase()),
                ),
                title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(user.email),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // 💡 点击弹出你写的详情审批面板
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FractionallySizedBox(
                      heightFactor: 0.8,
                      child: StaffManagementDetails(user: user),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
