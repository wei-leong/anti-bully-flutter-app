import 'dart:async';

import 'package:apu_assignment/features/auth/data/auth_providers.dart';
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
      final auth = ref.read(firebaseAuthProvider);
      final repository = ref.read(reportRepositoryProvider);

      final currentUser = auth.currentUser;
      if (currentUser == null) throw Exception("No user logged in");

      final newReport = ReportModel(
        location: location,
        uid: currentUser.uid,
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
