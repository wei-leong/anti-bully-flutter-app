import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUserList() {
    return _db
        .collection('user')
        .where('role', isEqualTo: 'user')
        .where('accountStatus', isEqualTo: 'approved')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return UserModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }
}
