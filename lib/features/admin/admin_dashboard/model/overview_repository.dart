import 'package:apu_assignment/features/admin/admin_dashboard/model/overview_services.dart';

class OverviewRepository {
  final OverviewServices overviewServices;

  OverviewRepository(this.overviewServices);

  Future<int> getTotalReport() async {
    try {
      return await overviewServices.getTotalReportCount();
    } catch (e) {
      throw Exception('Failed to Get Count: $e');
    }
  }

  Future<int> getActiveCases() async {
    try {
      return await overviewServices.getActiveCasesCount();
    } catch (e) {
      throw Exception('Failed to Get Count: $e');
    }
  }

  Future<int> getAllResources() async {
    try {
      return await overviewServices.getAllResourcesCount();
    } catch (e) {
      throw Exception('Failed to Get Count: $e');
    }
  }

  Future<int> getPendingCounselor() async {
    try {
      return await overviewServices.getPendingCounselorCount();
    } catch (e) {
      throw Exception('Failed to Get Count: $e');
    }
  }
}