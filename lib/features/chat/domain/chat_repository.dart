import 'package:apu_assignment/features/chat/domain/chat_model.dart';
import 'package:apu_assignment/features/chat/domain/chat_services.dart';

class ChatRepository {
  final ChatServices chatServices;

  ChatRepository(this.chatServices);

  Future<void> sendMessage(
    ChatModel message
  ) async {
    try {
      await chatServices.sendMessage(message.toMap(), message.senderUid, message.receiverUid);
    } catch (e) {
      throw Exception('Failed to Send Message: $e');
    }
  }

  Stream<List<ChatModel>> getMessages(String senderUid, String receiverUid) {
    try {
      final rawStream = chatServices.getMessages(senderUid, receiverUid);
      return rawStream.map((snapshot){
        return snapshot.docs.map((doc){
          return ChatModel.fromMap(doc.data(), doc.id);
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to Receive Message: $e');
    }
  }
}
