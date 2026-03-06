import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_detail_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatTileWidget extends ConsumerWidget {
  final String message;
  final String receiverUid;
  final String time;
  // bool isOnline = false;
  // bool isPinned = false;

  const ChatTileWidget({
    super.key,
    required this.message,
    required this.receiverUid,
    required this.time,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiverAsyncValue = ref.watch(userNameProvider(receiverUid));
    final String name = receiverAsyncValue.when(data: (user) => user?.name ?? '', error: (error,stack) => "User", loading: () => "User");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade600,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
        title: Text(
          name,
        ),
        subtitle: Text(message,maxLines: 2,overflow: TextOverflow.ellipsis,),
        trailing: Text(time),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatDetailScreens(receiverName: name, receiverUid: receiverUid),
            ),
          );
        },
      ),
    );
  }
}
