import 'dart:async';

import 'package:apu_assignment/features/report/data/report_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminReportIncidentViewModelProvider =
    AsyncNotifierProvider<AdminReportIncidentViewModel, void>(
      AdminReportIncidentViewModel.new,
    );

class AdminReportIncidentViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> assignCounselor(String reportId, String counselorId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(reportRepositoryProvider);

      await repository.assignCounselor(reportId, counselorId);
      ref.invalidate(userReportsProvider);
    });
  }
}
