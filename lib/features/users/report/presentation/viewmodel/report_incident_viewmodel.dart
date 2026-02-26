import 'dart:async';

import 'package:apu_assignment/features/users/report/data/report_providers.dart';
import 'package:apu_assignment/features/users/report/model/report_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportIncidentViewModelProvider =
    AsyncNotifierProvider<ReportIncidentViewModel, void>(
      ReportIncidentViewModel.new,
    );

class ReportIncidentViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submitReport({
    required String location,
    required String description,
    required ReportType reportType,
    required DateTime incidentDate,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(reportRepositoryProvider);

      final newReport = ReportModel(
        location: location,
        description: description,
        reportType: reportType,
        reportUrgentLevel: ReportUrgentLevel.med,
        reportStatus: ReportStatus.pending,
        incidentDate: incidentDate,
        createdAt: DateTime.now(),
      );

      await repository.saveReport(newReport);
    });
  }
}
