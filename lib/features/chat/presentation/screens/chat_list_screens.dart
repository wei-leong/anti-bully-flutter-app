import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/chat/data/chat_providers.dart';
import 'package:apu_assignment/features/chat/presentation/widgets/chat_tile_widget.dart';
import 'package:apu_assignment/features/users/counselor_list/presentation/screens/counselor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListScreens extends ConsumerWidget {
  final String userUid;
  final bool isCounselor;

  const ChatListScreens({super.key, required this.userUid, required this.isCounselor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListStream = ref.watch(chatRoomsStreamProvider(userUid));

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(fontWeight: FontWeight.bold)),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications_rounded)),
        //   Padding(
        //     padding: const EdgeInsets.only(right: kDefaultPadding),
        //     child: Container(
        //       decoration: BoxDecoration(shape: BoxShape.circle),
        //       child: CircleAvatar(child: Icon(Icons.person)),
        //     ),
        //   ),
        // ],
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
                          final receiverId = listDetails
                              .participants // TODO : Change this to Receiver Name
                              .firstWhere(
                                (id) => id != userUid,
                                orElse: () => "Unknown User",
                              );
                          return ChatTileWidget(
                            message: listDetails.lastMessage,
                            receiverUid: receiverId,
                            time: listDetails.lastMessageTime,
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
      floatingActionButton: isCounselor ? null : FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CounselorListScreen()),
          );
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
