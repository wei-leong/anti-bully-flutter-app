import 'package:cloud_firestore/cloud_firestore.dart';

class ReportServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveReport(Map<String, dynamic> rawData) async {
    await _db.collection('reports').add(rawData);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserReports(String uid) async {
    return await _db
        .collection('reports')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();
  }

  Future<void> deleteReport(String reportId) async {
    await _db.collection('reports').doc(reportId).delete();
  }
}
