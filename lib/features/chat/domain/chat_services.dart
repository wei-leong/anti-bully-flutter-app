import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String getChatRoomId(String senderUid, String receiverUid) {
    List ids = [senderUid, receiverUid];
    ids.sort();
    return ids.join('-');
  }

  Future<void> sendMessage(
    Map<String, dynamic> rawData,
    String senderUid,
    String receiverUid,
  ) async {
    String chatRoomId = getChatRoomId(senderUid, receiverUid);

    await _db
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(rawData);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    String senderUid,
    String receiverUid,
  ) {
    String chatRoomId = getChatRoomId(senderUid, receiverUid);

    return _db
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
