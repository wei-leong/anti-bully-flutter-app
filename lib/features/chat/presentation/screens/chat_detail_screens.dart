import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatDetailScreens extends StatelessWidget {
  const ChatDetailScreens({super.key});

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
                _messageBubble(
                  context,
                  message:
                      "Hi there. I noticed you requested a chat session. I'm here to listen. How are you feeling today?",
                  time: "10:00 AM",
                  isMe: false,
                ),

                // Sent Message
                _messageBubble(
                  context,
                  message:
                      "Hi Dr. Emily. I've been having a really hard time at school lately.",
                  time: "10:02 AM",
                  isMe: true,
                ),

                // Received Message
                _messageBubble(
                  context,
                  message:
                      "I'm sorry to hear that. You've taken a brave step by reaching out. Do you want to tell me more?",
                  time: "10:03 AM",
                  isMe: false,
                ),

                // Sent Message
                _messageBubble(
                  context,
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

  Widget _messageBubble(
    BuildContext context, {
    required String message,
    required String time,
    required bool isMe,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? colorScheme.primary : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
            bottomLeft: isMe
                ? Radius.circular(kDefaultPadding)
                : Radius.circular(0),
            bottomRight: isMe
                ? Radius.circular(0)
                : Radius.circular(kDefaultPadding),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: isMe
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: isMe
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
