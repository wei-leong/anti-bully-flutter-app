import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/users/data/resource_item.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/article_tile.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  String _selectedFilters = "All";
  final List<String> _filters = ["All", "Articles", "Videos", "News"];

  // Mock Data
  // TODO : Remove after finishing Part 1
  final List<ResourceItem> _allResources = [
    ResourceItem(
      title: "How to Prevent Bullying",
      source: "UNICEF",
      type: "article",
      durationOrSize: "5 min",
    ),
    ResourceItem(
      title: "What is Cyberbullying?",
      source: "StopBullying.gov",
      type: "article",
      durationOrSize: "3 min",
    ),
    ResourceItem(
      title: "Be a Buddy, Not a Bully",
      source: "Edu Series",
      type: "video",
      durationOrSize: "03:45",
    ),
    ResourceItem(
      title: "The Price of Shame",
      source: "TedTalk",
      type: "video",
      durationOrSize: "22:10",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<ResourceItem> displayedItems = _allResources;

    void returnResource() {
      if (_selectedFilters == "All") {
        displayedItems = _allResources;
      } else {
        displayedItems = _allResources
            .where(
              (item) =>
                  item.type.toLowerCase() ==
                  _selectedFilters.toLowerCase().substring(
                    0,
                    item.type.length > 5 ? 5 : 4,
                  ),
            )
            .toList();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Resources", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: "Search Resources",
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(kDefaultRadius),
            //     ),
            //     // filled: true, //TODO: Add back later (Now just Wireframe)
            //   ),
            // ),
            // Filter Chips
            // Single Child Scroll View
            SingleChildScrollView(
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
                          returnResource();
                        });
                      },
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
            // Content Area
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(kDefaultPadding),
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final item = displayedItems[index];
                  // Choose widget based on type
                  if (item.type == "video") {
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
