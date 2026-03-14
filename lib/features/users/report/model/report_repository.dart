import 'package:apu_assignment/features/users/report/model/report_model.dart';
import 'package:apu_assignment/features/users/report/model/report_services.dart';

class ReportRepository {
  final ReportServices reportServices;

  ReportRepository(this.reportServices);

  Future<void> saveReport(ReportModel report) async {
    try {
      await reportServices.saveReport(report.toMap());
    } catch (e) {
      throw Exception('Failed to Save Report: $e');
    }
  }

  Future<void> deleteReport(String reportId) async {
    try {
      await reportServices.deleteReport(reportId);
    } catch (e) {
      throw Exception('Failed to Delete Report: $e');
    }
  }

  Future<List<ReportModel>> getUserReports(String uid) async {
    try {
      final snapshot = await reportServices.getUserReports(uid);
      return snapshot.docs.map((doc) {
        return ReportModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to Get Report: $e');
    }
  }
}
