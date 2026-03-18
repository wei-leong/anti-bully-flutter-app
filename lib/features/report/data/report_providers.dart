import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:apu_assignment/features/report/model/report_repository.dart';
import 'package:apu_assignment/features/report/model/report_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportServicesProvider = Provider<ReportServices>((ref) {
  return ReportServices();
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  final services = ref.watch(reportServicesProvider);
  return ReportRepository(services);
});

final userReportsProvider = FutureProvider.autoDispose<List<ReportModel>>((ref) async {
  final auth = ref.watch(firebaseAuthProvider);
  final currentUser = auth.currentUser;

  if(currentUser == null){
    return [];
  }

  final repository = ref.watch(reportRepositoryProvider);
  return await repository.getUserReports(currentUser.uid);
});