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

    // Update Parent Room Document
    await _db.collection('chats').doc(chatRoomId).set({
      'participants': [senderUid, receiverUid],
      'lastMessage': rawData['message'],
      'lastMessageTime': rawData['timeStamp'],
    }, SetOptions(merge: true));

    // Save Message in Sub-collection
    await _db
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(rawData);
  }

  // Get Active Chat for the ChatListScreen()
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRooms(String uid) {
    return _db
        .collection('chats')
        .where('participants', arrayContains: uid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
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
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
