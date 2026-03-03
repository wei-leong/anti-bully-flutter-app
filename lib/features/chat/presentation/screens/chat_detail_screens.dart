import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ChatDetailScreens extends ConsumerStatefulWidget {
  const ChatDetailScreens({super.key});

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
            Text("Counselor Support", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Content Area
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "TODAY",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MessageBubble(
                  message:
                      "Hi there. I noticed you requested a chat session. I'm here to listen. How are you feeling today?",
                  time: "10:00 AM",
                  isMe: false,
                ),

                // Sent Message
                MessageBubble(
                  message:
                      "Hi Dr. Emily. I've been having a really hard time at school lately.",
                  time: "10:02 AM",
                  isMe: true,
                ),

                // Received Message
                MessageBubble(
                  message:
                      "I'm sorry to hear that. You've taken a brave step by reaching out. Do you want to tell me more?",
                  time: "10:03 AM",
                  isMe: false,
                ),

                // Sent Message
                MessageBubble(
                  message:
                      "It's a group of students in my history class. They keep posting mean comments...",
                  time: "10:05 AM",
                  isMe: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                  onPressed: () {},
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
