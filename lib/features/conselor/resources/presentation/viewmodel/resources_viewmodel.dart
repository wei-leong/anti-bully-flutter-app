import 'package:apu_assignment/features/conselor/resources/data/resources_provider.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final resourceRepoProvider = Provider((ref) => ResourcesProvider());

// Manage filter (Articles, Event, Video, New)
class ResourceFilterNotifier extends Notifier<String> {
  @override
  String build() {
    return "Articles"; // default
  }

  void updateFilter(String newFilter) {
    state = newFilter; // update status
  }
}

final resourceFilterProvider = NotifierProvider<ResourceFilterNotifier, String>(() {
  return ResourceFilterNotifier();
});

// Get data (ResourcesItem)
final allResourcesProvider = FutureProvider<List<ResourceItem>>((ref) async {
  return ref.watch(resourceRepoProvider).fetchResources();
});

// Fill provider
final filteredResourcesProvider = Provider<AsyncValue<List<ResourceItem>>>((ref) {
  final allResourcesAsync = ref.watch(allResourcesProvider);
  final selectedFilter = ref.watch(resourceFilterProvider).toLowerCase();

  return allResourcesAsync.whenData((list) {
    String filterType = selectedFilter == "news" ? "new" : selectedFilter;
    return list.where((item) => item.type.toLowerCase() == filterType).toList();
  });
});