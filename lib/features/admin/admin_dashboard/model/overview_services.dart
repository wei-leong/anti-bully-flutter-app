import 'package:cloud_firestore/cloud_firestore.dart';

class OverviewServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<int> getTotalReportCount() async {
    final snapshot = await _db.collection('reports').count().get();
    return snapshot.count ?? 0;
  }

  Future<int> getActiveCasesCount() async {
    final snapshot = await _db
        .collection('reports')
        .where('reportStatus', isEqualTo: 'pending')
        .count()
        .get();
    return snapshot.count ?? 0;
  }

  Future<int> getAllResourcesCount() async {
    final articlesSnapshot = await _db.collection('articles').count().get();
    final videosSnapshot = await _db.collection('videos').count().get();
    final eventsSnapshot = await _db.collection('events').count().get();
    final newsSnapshot = await _db.collection('news').count().get();

    final articlesCount = articlesSnapshot.count ?? 0;
    final videosCount = videosSnapshot.count ?? 0;
    final eventsCount = eventsSnapshot.count ?? 0;
    final newsCount = newsSnapshot.count ?? 0;
    
    final totalResources = articlesCount + videosCount + eventsCount + newsCount;

    return totalResources;
  }

  Future<int> getPendingCounselorCount() async {
    final snapshot = await _db
        .collection('user')
        .where('accountStatus', isEqualTo: 'pending')
        .count()
        .get();
    return snapshot.count ?? 0;
  }
}
