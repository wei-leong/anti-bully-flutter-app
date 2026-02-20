import 'package:apu_assignment/features/conselor/resources/data/resources_provider.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 定义 Repository 的 Provider
final resourceRepoProvider = Provider((ref) => ResourcesProvider());

// 2. 当前选中的 Filter 状态 (默认 Articles)
final resourceFilterProvider = StateProvider<String>((ref) => "Articles");

// 3. 异步获取所有数据的 Provider
final allResourcesProvider = FutureProvider<List<ResourceItem>>((ref) async {
  return ref.watch(resourceRepoProvider).fetchResources();
});

// 4. 核心逻辑：根据 Filter 过滤后的数据 Provider
final filteredResourcesProvider = Provider<AsyncValue<List<ResourceItem>>>((ref) {
  final allResourcesAsync = ref.watch(allResourcesProvider);
  final selectedFilter = ref.watch(resourceFilterProvider).toLowerCase();

  return allResourcesAsync.whenData((list) {
    // 处理 "News" 标签对应模型中的 "new" 类型
    String filterType = selectedFilter == "news" ? "new" : selectedFilter;
    return list.where((item) => item.type.toLowerCase() == filterType).toList();
  });
});