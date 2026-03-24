import 'package:apu_assignment/features/chat/presentation/screens/chat_detail_screens.dart';
import 'package:apu_assignment/features/conselor/user_list/data/user_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListStream = ref.watch(userListStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with User"),
      ),
      body: userListStream.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text("No users available"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreens(receiverUid: user.uid, receiverName: user.name)));
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
