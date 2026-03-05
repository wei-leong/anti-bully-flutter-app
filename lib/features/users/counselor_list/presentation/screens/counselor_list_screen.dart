import 'package:apu_assignment/features/chat/presentation/screens/chat_detail_screens.dart';
import 'package:apu_assignment/features/users/counselor_list/data/counselor_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounselorListScreen extends ConsumerWidget {
  const CounselorListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colorScheme = Theme.of(context).colorScheme;

    final counselorListStream = ref.watch(counselorListStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Get Help"),
      ),
      body: counselorListStream.when(
        data: (counselors) {
          if (counselors.isEmpty) {
            return const Center(child: Text("No counselors available"));
          }

          return ListView.builder(
            itemCount: counselors.length,
            itemBuilder: (context, index) {
              final counselor = counselors[index];

              return ListTile(
                title: Text(counselor.name),
                subtitle: Text(counselor.email),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreens(receiverUid: counselor.uid, receiverName: counselor.name)));
                  },
                  icon: Icon(Icons.chat_bubble_outline),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text("Error : $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
