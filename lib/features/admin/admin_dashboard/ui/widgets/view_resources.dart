import 'dart:typed_data';
import 'package:apu_assignment/features/Images/data/image_provider.dart';
import 'package:apu_assignment/features/resources/data/resources_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:gap/gap.dart';

class ResourceDetails extends ConsumerWidget { 
  final dynamic resourceItem;

  const ResourceDetails({super.key, required this.resourceItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = resourceItem.type.toLowerCase();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const Gap(12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTypeLabel(type),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resourceItem.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Gap(8),
                  _buildMetaInfo("Posted by ${resourceItem.source}", Icons.person_outline),
                  const Gap(20),

                  ...buildTypeContent(context, type),

                  const Gap(30),

                  Row(
                    children: [
                      // Button 1
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _handleUpdateStatus(context, ref, 'rejected'),
                          icon: const Icon(Icons.close, color: Colors.red),
                          label: const Text("Reject", style: TextStyle(color: Colors.red)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const Gap(16),
                      // Button 2
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _handleUpdateStatus(context, ref, 'approved'),
                          icon: const Icon(Icons.check, color:Colors.lightGreenAccent),
                          label: const Text("Approve", style: TextStyle(color:Colors.lightGreenAccent),),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.lightGreenAccent),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Use to updated resources status
  void _handleUpdateStatus(BuildContext context, WidgetRef ref, String newStatus) async {
      // Get resources id from collection (event, articles, news and videos)
      final collectionName = resourceItem.type.toLowerCase(); 
      final documentId = resourceItem.id; 

      await ref.read(resourcesRepositoryProvider).updateResourceStatus(
        collectionName, 
        documentId, 
        newStatus
      );
    Navigator.pop(context); 
}
  

  // Build content by each type of resources

  List<Widget> buildTypeContent(BuildContext context, String type) {
    final normalizedType = type.toLowerCase();
    final Uint8List? imageBytes = ImagesProvider.decodeBase64(resourceItem.content['image']);

    switch (normalizedType) {
      case 'videos':
        return [
          const Text("Video Link", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
                resourceItem.content['video_url_(youtube_only)'] ?? "No Link Provided",
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
          ),
          const Gap(20),
          const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(8),
          Text(resourceItem.content['content'] ?? "No description available.",
              style: const TextStyle(fontSize: 15)),
        ];

      case 'articles':
        return [
          if (imageBytes != null) ...[
            _buildImageContainer(imageBytes),
          ],
          _buildInfoRow(
              "Duration (Minute)",
              resourceItem.content['duration_of_learn_(ep:_5_min/_2_hours)'] ?? "N/A",
              Icons.timeline),
          const Gap(20),
          const Text("Content", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(12),
          Text(resourceItem.content['content'] ?? "No content available.",
              style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87)),
        ];

      case 'news':
      case 'events':
        return [
          if (imageBytes != null) _buildImageContainer(imageBytes),
          _buildInfoRow("Location", resourceItem.content['location'] ?? "N/A", Icons.location_on),
          const Gap(12),
          _buildInfoRow("Date", resourceItem.content['date'] ?? "N/A", Icons.calendar_month),
          const Gap(20),
          const Text("Content", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(8),
          Text(resourceItem.content['content'] ?? "No content.", style: const TextStyle(fontSize: 15)),
        ];

      default:
        return [Text(resourceItem.content.toString())];
    }
  }

  Widget _buildImageContainer(Uint8List bytes) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(bytes, fit: BoxFit.cover),
      ),
    );
  }

  String _getTypeLabel(String type) => type.toUpperCase();

  Widget _buildMetaInfo(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const Gap(6),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }
}