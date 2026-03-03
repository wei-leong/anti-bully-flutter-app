import 'dart:async';

import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/data/chat_providers.dart';
import 'package:apu_assignment/features/chat/domain/chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatViewModelProvider = AsyncNotifierProvider(ChatViewmodel.new);

class ChatViewmodel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessage(String message, String receiverUid) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final auth = ref.read(firebaseAuthProvider);
      final currentUser = auth.currentUser;

      final repository = ref.read(chatRepositoryProvider);

      if (currentUser == null) {
        throw Exception("Cannot send message: No user is logged in.");
      }

      final newMessage = ChatModel(
        message: message.trim(),
        senderUid: currentUser.uid,
        receiverUid: receiverUid,
        timeStamp: DateTime.now(),
        isRead: false,
      );

      await repository.sendMessage(newMessage);
    });
  }
}
