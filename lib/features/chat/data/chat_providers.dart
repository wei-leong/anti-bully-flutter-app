import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/chat/domain/chat_model.dart';
import 'package:apu_assignment/features/chat/domain/chat_repository.dart';
import 'package:apu_assignment/features/chat/domain/chat_room_model.dart';
import 'package:apu_assignment/features/chat/domain/chat_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatServiceProvider = Provider<ChatServices>((ref){
  return ChatServices();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref){
  final service = ref.watch(chatServiceProvider);
  return ChatRepository(service);
});

final chatStreamProvider = StreamProvider.autoDispose.family<List<ChatModel>, String>((ref,receiverUid) {
  final auth = ref.watch(firebaseAuthProvider);
  final currentUser = auth.currentUser;

  if(currentUser == null){
    return Stream.value([]);
  }

  final repository = ref.watch(chatRepositoryProvider);

  return repository.getMessages(currentUser.uid, receiverUid);
});

final chatRoomsStreamProvider = StreamProvider.autoDispose.family<List<ChatRoomModel>,String>((ref, uid) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChatRooms(uid);
});