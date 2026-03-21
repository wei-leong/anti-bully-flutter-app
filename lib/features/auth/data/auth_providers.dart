import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:apu_assignment/features/auth/model/user_repository.dart';
import 'package:apu_assignment/features/auth/model/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref){
  return FirebaseAuth.instance;
});

final userServiceProvider = Provider<UserServices>((ref){
  return UserServices();
});

final userRepositoryProvider = Provider<UserRepository>((ref){
  final service = ref.watch(userServiceProvider);
  return UserRepository(service);
});

final userNameProvider = FutureProvider.family<UserModel?, String>((ref,uid){
  final repo = ref.watch(userRepositoryProvider);
  return repo.getUser(uid);
});

final pendingUsersProvider = StreamProvider<List<UserModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('user')
      .where('accountStatus', isEqualTo: 'pending') 
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList());
});