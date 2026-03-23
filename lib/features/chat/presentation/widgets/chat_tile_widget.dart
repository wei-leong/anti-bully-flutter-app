import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/data/chat_providers.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_detail_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatTileWidget extends ConsumerWidget {
  final String message;
  final String receiverUid;
  final DateTime time;
  final bool isUnread;

  const ChatTileWidget({
    super.key,
    required this.message,
    required this.receiverUid,
    required this.time,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiverAsyncValue = ref.watch(userNameProvider(receiverUid));
    final String name = receiverAsyncValue.when(
      data: (user) => user?.name ?? '',
      error: (error, stack) => "User",
      loading: () => "User",
    );

    final now = DateTime.now();
    final isToday =
        time.year == now.year && time.month == now.month && time.day == now.day;

    final displayTime = isToday
        ? DateFormat.jm().format(time)
        : DateFormat('dd/MM/yyyy').format(time);

    final fontWeight = isUnread ? FontWeight.bold : FontWeight.normal;
    final textColor = isUnread
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          children: [CircleAvatar(radius: 24, child: Icon(Icons.person))],
        ),
        title: Text(name, style: TextStyle(fontWeight: fontWeight)),
        subtitle: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: fontWeight, color: textColor),
        ),
        trailing: Text(
          displayTime,
          style: TextStyle(fontWeight: fontWeight, color: textColor),
        ),
        onTap: () {
          if (isUnread) {
            final uid = FirebaseAuth.instance.currentUser!.uid;
            List ids = [uid, receiverUid];
            ids.sort();
            String roomId = ids.join('-');

            ref.read(chatServiceProvider).markRoomAsRead(roomId);
          }

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
      ),
    );
  }
}
