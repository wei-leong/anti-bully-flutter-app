import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:apu_assignment/features/report/presentation/viewmodel/report_incident_viewmodel.dart';
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
        .orderBy('incidentDate', descending: true)
        .get();
  }

  Future<void> deleteReport(String reportId) async {
    await _db.collection('reports').doc(reportId).delete();
  }

  Future<void> assignCounselor(String reportId,String counselorId) async {
    await _db.collection('reports').doc(reportId).update({
      'assignedCounselorId':counselorId,
      'reportStatus': ReportStatus.inProgress.name // Update from Pending to In Progress
    });
  }
}
