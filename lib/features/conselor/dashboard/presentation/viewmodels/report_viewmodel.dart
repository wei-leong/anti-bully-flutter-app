import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/dashboard/data/report_provider.dart';
import 'package:apu_assignment/features/conselor/dashboard/model/report_model.dart';

// report provider
final reportRepositoryProvider = Provider((ref) => ReportRepository());

// read from data/report_provider to get data
final reportProvider = FutureProvider<List<ReportModel>>((ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.fetchReports(); 
});