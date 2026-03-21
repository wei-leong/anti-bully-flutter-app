import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/article_tile.dart';
import 'package:apu_assignment/features/users/resources/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  String _selectedFilters = "Articles";
  final List<String> _filters = ["Articles", "Videos", "News", "Events"];

  // Mock Data
  // TODO : Remove after finishing Part 1
  final List<ResourceItem> _allResources = [
    ResourceItem(
      title: "How to Prevent Bullying",
      source: "UNICEF",
      type: "articles",
      durationOrSize: "5 min",
      imageUrl: 'https://img.freepik.com/free-psd/world-day-bullying-prevention-template-design_23-2151371506.jpg?semt=ais_hybrid&w=740&q=80'
    ),
    ResourceItem(
      title: "What is Cyberbullying?",
      source: "StopBullying.gov",
      type: "articles",
      durationOrSize: "3 min",
    ),
    ResourceItem(
      title: "Be a Buddy, Not a Bully",
      source: "Edu Series",
      type: "videos",
      durationOrSize: "03:45",
    ),
    ResourceItem(
      title: "The Price of Shame",
      source: "TedTalk",
      type: "videos",
      durationOrSize: "22:10",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<ResourceItem> displayedItems;

    displayedItems = _allResources
        .where(
          (item) =>
              item.type.toLowerCase() ==
              _selectedFilters.toLowerCase(),
        )
        .toList();

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
              child: ListView.builder(
                // padding: const EdgeInsets.all(kDefaultPadding),
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final item = displayedItems[index];
                  // Choose widget based on type
                  if (item.type == "videos") {
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
