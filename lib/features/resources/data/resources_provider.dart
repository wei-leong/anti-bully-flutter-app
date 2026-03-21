import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class ResourcesProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ResourceItem>> fetchResources({String status = "approved"}) {
  List<String> collections = ["articles", "videos", "news", "events"];
  
  return CombineLatestStream.list<List<ResourceItem>>(
    collections.map((col) => _firestore
        .collection(col)
        .where("status", isEqualTo: status)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => ResourceItem.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList())),
  ).map((lists) => lists.expand((x) => x).toList()); 
}

  Future<void> updateResourceStatus(String col, String id, String newStatus) async {
  await _firestore.collection(col).doc(id).update({
    'status': newStatus,
    'updatedAt': FieldValue.serverTimestamp(), 
  });
}
}

final resourcesRepositoryProvider = Provider((ref) => ResourcesProvider());

final resourcesProvider = StreamProvider<List<ResourceItem>>((ref) {
  return ResourcesProvider().fetchResources(status: "approved");
});

final pendingResourcesProvider = StreamProvider<List<ResourceItem>>((ref) {
  return ResourcesProvider().fetchResources(status: "pending");
});