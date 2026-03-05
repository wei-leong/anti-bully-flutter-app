import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/chat/data/chat_providers.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_detail_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ChatListScreens extends ConsumerWidget {
  final String userUid;

  const ChatListScreens({super.key, required this.userUid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListStream = ref.watch(chatRoomsStreamProvider(userUid));

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_rounded)),
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatListStream.when(
              data: (lists) {
                if (lists.isEmpty) {
                  return const Center(child: Text("No Active Chats"));
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: lists.length,
                        itemBuilder: (context, index) {
                          final listDetails = lists[index];
                          final receiverId = listDetails.participants // TODO : Change this to Receiver Name
                              .firstWhere(
                                (id) => id != userUid,
                                orElse: () => "Unknown User",
                              );
                          return _buildChatTile(
                            context,
                            name: receiverId,
                            message: listDetails.lastMessage,
                            receiverUid: receiverId,
                            time: listDetails.lastMessageTime.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text("Error occurred : $error"));
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_comment),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context, {
    required String name,
    required String message,
    required String receiverUid,
    required String time,
    bool isOnline = false,
    bool isPinned = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade600,
            child: Icon(Icons.person, color: Colors.white),
          ),
          if (isOnline)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreens(
              receiverName: name,
              receiverUid: receiverUid,
            ),
          ),
        );
      },
    );
  }
}
