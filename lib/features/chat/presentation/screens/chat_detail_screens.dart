import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/data/chat_providers.dart';
import 'package:apu_assignment/features/chat/presentation/viewmodel/chat_viewmodel.dart';
import 'package:apu_assignment/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class ChatDetailScreens extends ConsumerStatefulWidget {
  final String receiverUid;
  final String receiverName;

  const ChatDetailScreens({super.key, required this.receiverUid, required this.receiverName});

  @override
  ConsumerState<ChatDetailScreens> createState() => _ChatDetailScreensState();
}

class _ChatDetailScreensState extends ConsumerState<ChatDetailScreens> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chatStream = ref.watch(chatStreamProvider(widget.receiverUid));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Gap between Return Arrow and Profile Picture
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.surfaceContainerHighest,
              child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
            ),
            Gap(8),
            // TODO : Create methods for getting receiver name
            Text(widget.receiverName, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatStream.when(
              data: (messages) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final currentUserId = ref.read(firebaseAuthProvider).currentUser?.uid;
                          final bool isMe = messages[index].senderUid == currentUserId;
                          return MessageBubble(
                            message: messages[index].message,
                            time: messages[index].timeStamp,
                            isMe: isMe,
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
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.image_outlined),
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                IconButton.filled(
                  //! Send Button
                  onPressed: () {
                    ref
                        .read(chatViewModelProvider.notifier)
                        .sendMessage(
                          _messageController.text,
                          widget.receiverUid,
                        ); // TODO : Change Receiver ID
                    _messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    fixedSize: const Size(
                      50,
                      50,
                    ), // Ensures it's a nice big circle
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
