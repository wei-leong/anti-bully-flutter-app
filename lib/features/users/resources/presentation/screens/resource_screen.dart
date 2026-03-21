import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/resources/data/user_resources_provider.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/article_tile.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResourceScreen extends ConsumerStatefulWidget {
  const ResourceScreen({super.key});

  @override
  ConsumerState<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends ConsumerState<ResourceScreen> {
  String _selectedFilters = "Articles";
  final List<String> _filters = ["Articles", "Videos", "News", "Events"];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resourcesAsync = ref.watch(liveResourcesStreamProvider);

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
                  children: _filters.map((item) {
                    final isSelected = _selectedFilters == item;
                    return Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding),
                      child: FilterChip(
                        label: Text(item),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedFilters = item;
                          });
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
              child: resourcesAsync.when(
                data: (allResources) {
                  // Filter the live data based on the selected chip
                  final displayedItems = allResources
                      .where((item) => item.type.toLowerCase() == _selectedFilters.toLowerCase())
                      .toList();

                  // Show a friendly message if a category is empty
                  if (displayedItems.isEmpty) {
                    return Center(
                      child: Text(
                        "No ${_selectedFilters.toLowerCase()} available right now.",
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) {
                      final item = displayedItems[index];
                      
                      // Choose widget based on type
                      // Make sure to use .toLowerCase() for safety!
                      if (item.type.toLowerCase() == "videos") {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: VideoCard(resourceItem: item),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ArticleTile(resourceItem: item),
                        );
                      }
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text("Failed to load resources: $error")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
