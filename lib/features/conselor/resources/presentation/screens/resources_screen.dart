import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/viewmodel/resources_viewmodel.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/widget/artical_tile.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/widget/event_poster.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/widget/video_cart.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/widget/new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResourceScreen extends ConsumerWidget {
  const ResourceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredResourcesAsync = ref.watch(filteredResourcesProvider);

    final selectedFilter = ref.watch(resourceFilterProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final List<String> _filters = ["Articles", "Videos", "News", "Events"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Resources", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            // Single Child Scroll View
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) { // 注意变量名建议改为 filter
                    final isSelected = selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected, // 之前这里漏掉了变量名
                        onSelected: (bool selected) {
                          // 更新 Riverpod 中的状态
                          ref.read(resourceFilterProvider.notifier).updateFilter(filter);
                        },
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Content Area
            Expanded(
            child: filteredResourcesAsync.when(
              data: (items) => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  // 根据类型返回对应的 Widget (逻辑与你之前一致)
                  if (item.type == "videos") return VideoCard(resourceItem: item);
                  if (item.type == "events") return EventPosterCard(resourceItem: item);
                  if (item.type == "news") return NewsOrEventTile(resourceItem: item);
                  return ArticleTile(resourceItem: item);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
