import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/report/model/report_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/dashboard/data/report_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

// report provider
final reportRepositoryProvider = Provider((ref) => ReportRepository());

// read from data/report_provider to get data
final reportProvider = StreamProvider<List<ReportModel>>((ref){
  final repository = ref.watch(reportRepositoryProvider);
  final auth = ref.watch(firebaseAuthProvider);
  final uid = auth.currentUser?.uid ?? '';
  return repository.fetchReports(uid);
});


class ReportViewModel extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  ReportViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> updateStatus(String reportId, String newStatus) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      ref.read(reportRepositoryProvider).updateReportStatus(reportId, newStatus)
    );
  }
}

final reportViewModelProvider = StateNotifierProvider.autoDispose<ReportViewModel, AsyncValue<void>>((ref) {
  return ReportViewModel(ref);
});