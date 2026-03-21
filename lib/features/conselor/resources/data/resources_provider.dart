import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
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
        .map((snap) => snap.docs.map((doc) => ResourceItem.fromFirestore(doc.data())).toList())),
  ).map((lists) => lists.expand((x) => x).toList()); 
}
}

final resourcesProvider = StreamProvider<List<ResourceItem>>((ref) {
  return ResourcesProvider().fetchResources(status: "approved");
});

final pendingResourcesProvider = StreamProvider<List<ResourceItem>>((ref) {
  return ResourcesProvider().fetchResources(status: "pending");
});