import 'package:apu_assignment/features/users/report/model/report_repository.dart';
import 'package:apu_assignment/features/users/report/model/report_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportServicesProvider = Provider<ReportServices>((ref) {
  return ReportServices();
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  final services = ref.watch(reportServicesProvider);
  return ReportRepository(services);
});