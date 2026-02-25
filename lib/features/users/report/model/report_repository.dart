import 'package:apu_assignment/features/users/report/model/report_model.dart';
import 'package:apu_assignment/features/users/report/model/report_services.dart';

class ReportRepository {

  final ReportServices reportServices;

  ReportRepository(this.reportServices);

  Future<void> saveReport(ReportModel report) async {
    try{
      await reportServices.saveReport(report.toMap());
    } catch (e) {
      throw Exception('Failed to Save Report: $e');
    }
  }

}