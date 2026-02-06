import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/chat/presentation/screens/chat_detail_screens.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatListScreens extends StatelessWidget {
  const ChatListScreens({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(kDefaultPadding),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search Counselors",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  // filled: true, //TODO: Add back later (Now just Wireframe)
                ),
              ),

              const Gap(20),
              // Pinned Section
              _buildSectionHeader(context, "PINNED"),
              _buildChatTile(
                context,
                name: "Counselor Support",
                message: "Hi, how may I help you",
                time: "2 min ago",
                isOnline: true,
              ),

              // Recent Section
              _buildSectionHeader(context, "RECENT"),
              _buildChatTile(
                context,
                name: "Peer Support Group",
                message: "KH: Has anyone tried the new...",
                time: "Yesterday",
              ),
              _buildChatTile(
                context,
                name: "Siwa Kumaran",
                message: "Let's schedule a meeting to discuss...",
                time: "Last Week",
              ),
              _buildChatTile(
                context,
                name: "Student Council Rep",
                message: "Thanks for reaching out about the...",
                time: "Last Week",
              ),
            ],
          ),
        ),
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
          MaterialPageRoute(builder: (context) => ChatDetailScreens()),
        );
      },
    );
  }
}
