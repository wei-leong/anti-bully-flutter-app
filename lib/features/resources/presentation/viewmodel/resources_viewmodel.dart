import 'package:apu_assignment/features/conselor/resources/data/resources_provider.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final resourceRepoProvider = Provider((ref) => ResourcesProvider());

// Manage filter (Articles, Event, Video, New)
class ResourceFilterNotifier extends Notifier<String> {
  @override
  String build() {
    return "articles"; // default
  }

  void updateFilter(String newFilter) {
    state = newFilter; // update status
  }
}

final resourceFilterProvider = NotifierProvider<ResourceFilterNotifier, String>(() {
  return ResourceFilterNotifier();
});

// Get data (ResourcesItem)
final resourceRepositoryProvider = Provider((ref) => ResourcesProvider());
final resourcesProvider = StreamProvider<List<ResourceItem>>((ref) {
  final repository = ref.watch(resourceRepositoryProvider);
  
  return repository.fetchResources(); 
});

// Fill provider
final filteredResourcesProvider = Provider<AsyncValue<List<ResourceItem>>>((ref) {
  final allResourcesAsync = ref.watch(resourcesProvider);
  final filter = ref.watch(resourceFilterProvider);

  return allResourcesAsync.whenData((items) {
    final selectedFilter = filter.toLowerCase();
    if (selectedFilter == "articles") {
      return items.where((item) => item.type.toLowerCase() == "articles").toList();
    }
    return items.where((item) => item.type.toLowerCase() == selectedFilter).toList();
  });
});