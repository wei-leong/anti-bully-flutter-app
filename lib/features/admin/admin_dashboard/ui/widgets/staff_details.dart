import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class StaffManagementDetails extends ConsumerWidget {
  final UserModel user;

  const StaffManagementDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const Gap(12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Account Review", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(user.name[0].toUpperCase(), style: const TextStyle(fontSize: 32)),
                  ),
                  const Gap(16),
                  Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Chip(label: Text(user.role.name.toUpperCase())),
                  const Gap(32),

                  _buildDetailRow("Email", user.email, Icons.email_outlined),
                  const Gap(16),
                  _buildDetailRow("Applied On", user.createdAt.toString().split(' ')[0], Icons.calendar_today_outlined),
                  
                  const Gap(48),

                  Row(
                    children: [
                      // Reject 按钮
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handleUpdateUserStatus(context, ref, 'rejected'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Reject"),
                        ),
                      ),
                      const Gap(16),
                      // Approve 按钮
                      Expanded(
                        child: FilledButton(
                          onPressed: () => _handleUpdateUserStatus(context, ref, 'approved'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.lightGreenAccent,
                            side: const BorderSide(color: Colors.lightGreenAccent),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Approve"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleUpdateUserStatus(BuildContext context, WidgetRef ref, String newStatus) async {
    try {
      await ref.read(userRepositoryProvider).updateUserAccountStatus(user.uid, newStatus);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account ${user.name} has been $newStatus")),
        );
        Navigator.pop(context); 
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}