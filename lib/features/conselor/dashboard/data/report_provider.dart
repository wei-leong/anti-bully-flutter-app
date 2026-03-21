import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ReportModel>> fetchReports(String userUid) {
    return _firestore
        .collection('reports')
        .where('assignedCounselorId', isEqualTo: userUid)
        .where('reportStatus', whereIn: ['inProgress', 'Pending'])
        .snapshots()
        .map((snapshot) {
        return snapshot.docs.map((doc) {
          return ReportModel.fromMap(doc.data(),doc.id); 
        }).toList();
      });
  }

  Future<void> updateReportStatus(String reportId, String newStatus) async {
    await _firestore.collection('reports').doc(reportId).update({
      'reportStatus': newStatus,
    });
  }

 }

