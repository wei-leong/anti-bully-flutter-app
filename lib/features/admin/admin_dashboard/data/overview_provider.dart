import 'package:apu_assignment/features/admin/admin_dashboard/model/overview_repository.dart';
import 'package:apu_assignment/features/admin/admin_dashboard/model/overview_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final overviewServiceProvider = Provider<OverviewServices>((ref){
  return OverviewServices();
});

final overviewRepositoryProvider = Provider<OverviewRepository>((ref){
  final service = ref.watch(overviewServiceProvider);
  return OverviewRepository(service);
});

final totalReportCountProvider = FutureProvider.autoDispose<int>((ref) async {
  return await ref.watch(overviewRepositoryProvider).getTotalReport();
});

final totalActiveCaseCountProvider = FutureProvider.autoDispose<int>((ref) async {
  return await ref.watch(overviewRepositoryProvider).getActiveCases();
});

final totalAllResourcesCountProvider = FutureProvider.autoDispose<int>((ref) async {
  return await ref.watch(overviewRepositoryProvider).getAllResources();
});

final totalPendingCounselorCountProvider = FutureProvider.autoDispose<int>((ref) async {
  return await ref.watch(overviewRepositoryProvider).getPendingCounselor();
});