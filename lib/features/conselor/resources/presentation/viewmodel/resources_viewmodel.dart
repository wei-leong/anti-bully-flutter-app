import 'package:apu_assignment/features/conselor/resources/data/resources_provider.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 数据源 Provider (保持不变)
final resourceRepoProvider = Provider((ref) => ResourcesProvider());

// 2. 【替代方案】使用 Notifier 管理选中的标签状态
// 以前是 StateProvider<String>，现在是这个 Class
class ResourceFilterNotifier extends Notifier<String> {
  @override
  String build() {
    return "Articles"; // 初始状态
  }

  void updateFilter(String newFilter) {
    state = newFilter; // 更新状态
  }
}

// 对应的 Provider 定义
final resourceFilterProvider = NotifierProvider<ResourceFilterNotifier, String>(() {
  return ResourceFilterNotifier();
});

// 3. 异步获取所有数据的 Provider (保持不变)
final allResourcesProvider = FutureProvider<List<ResourceItem>>((ref) async {
  return ref.watch(resourceRepoProvider).fetchResources();
});

// 4. 过滤逻辑 Provider
final filteredResourcesProvider = Provider<AsyncValue<List<ResourceItem>>>((ref) {
  final allResourcesAsync = ref.watch(allResourcesProvider);
  final selectedFilter = ref.watch(resourceFilterProvider).toLowerCase();

  return allResourcesAsync.whenData((list) {
    String filterType = selectedFilter == "news" ? "new" : selectedFilter;
    return list.where((item) => item.type.toLowerCase() == filterType).toList();
  });
});