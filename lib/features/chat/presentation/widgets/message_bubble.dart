import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final DateTime time;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final now = DateTime.now();
    final isToday = time.year == now.year && time.month == now.month && time.day == now.day;

    final displayTime = isToday ? DateFormat.jm().format(time) : DateFormat('dd/MM/yyyy').format(time);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: kDefaultPadding),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
              displayTime,
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
