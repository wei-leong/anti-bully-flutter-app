import 'dart:typed_data';
import 'package:apu_assignment/features/Images/data/image_provider.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.resourceItem});

  final ResourceItem resourceItem;

  Uint8List? get _imageBytes {
    final content = resourceItem.content;
    if (content == null) return null;

    final String? base64String = content['image'];

    if (base64String == null || base64String.isEmpty) return null;
    return ImagesProvider.decodeBase64(base64String);
  }
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bytes = _imageBytes;

    // Check if we have an image
    final hasImage = bytes != null;
        

    return Container(
      // Card Container Styling
      decoration: BoxDecoration(
        color: colorScheme.surface, // Clean White/Black bg
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(12), // Inner padding for the whole card
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top
        children: [
          // Image Thumbnail for Article
          if (hasImage) ...[
            Container(
              width: 100, 
              height: 70, 
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest, 
                borderRadius: BorderRadius.circular(8),
                image: bytes != null
                    ? DecorationImage(
                        image: MemoryImage(bytes),
                        fit: BoxFit.cover,
                      )
                    : null, 
              ),
            ),
            const Gap(16), // Spacing between image and text
          ],
          
          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment
                  .center, // Center vertically relative to image
              children: [
                // Title
                Text(
                  resourceItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Slightly larger for readability
                    color: colorScheme.onSurface,
                  ),
                ),

                const Gap(8),

                // Source / Date (Subtitle)
                Text(
                  "${resourceItem.source} • ${resourceItem.durationOrSize}",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          //Chevron Icon (to indicate clickable)
          const Gap(8),
          Icon(
            Icons.chevron_right,
            color: colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ],
      ),
    );
  }
}
