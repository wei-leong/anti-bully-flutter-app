import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? id;
  final String message;
  final String senderUid;
  final String receiverUid;
  final DateTime timeStamp;
  final bool isRead;

  ChatModel({
    this.id,
    required this.message,
    required this.senderUid,
    required this.receiverUid,
    required this.timeStamp,
    required this.isRead,
  });

  factory ChatModel.fromMap(Map<String, dynamic> data, String id) {
    return ChatModel(
      id: id,
      message: data['message'] ?? '',
      senderUid: data['senderUid'] ?? '',
      receiverUid: data['receiverUid'] ?? '',
      timeStamp: (data['timeStamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'participants': [senderUid, receiverUid],
      'timeStamp': Timestamp.fromDate(timeStamp),
      'isRead': isRead,
    };
  }
}
