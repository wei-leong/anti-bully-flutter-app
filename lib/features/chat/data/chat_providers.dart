import 'package:apu_assignment/features/chat/domain/chat_repository.dart';
import 'package:apu_assignment/features/chat/domain/chat_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatServiceProvider = Provider<ChatServices>((ref){
  return ChatServices();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref){
  final service = ref.watch(chatServiceProvider);
  return ChatRepository(service);
});

// final chatStreamProvider = StreamProvider.autoDispose.family<List<MessageModel>, String>((ref, receiverUid) {
//   final auth = ref.watch(firebaseAuthProvider);
//   final currentUser = auth.currentUser;

//   // If no one is logged in, safely return an empty stream
//   if (currentUser == null) {
//     return Stream.value([]);
//   }

//   final repository = ref.watch(chatRepositoryProvider);
  
//   // Ask the repository for the live stream between the current user and the contact
//   return repository.getMessagesStream(currentUser.uid, receiverUid);
// });