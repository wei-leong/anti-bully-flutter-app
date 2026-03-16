import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:flutter/material.dart';

class EventPosterCard extends StatelessWidget {
  final ResourceItem resourceItem;
  // Image
  final String? imageUrl; 

  const EventPosterCard({
    super.key,
    required this.resourceItem,
    this.imageUrl, // Accepted using Image URL
  });

@override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      // Padding follow by vido_cart
      padding: const EdgeInsets.only(bottom: kDefaultPadding), 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          // Put user accout picture
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding), 
            child: CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                resourceItem.source.isNotEmpty ? resourceItem.source[0] : "?",
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
          ),
          
          const SizedBox(width: 12),

          // Event model
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant, 
                borderRadius: BorderRadius.circular(kDefaultRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  //Image
                  imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                          imageUrl!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                        )
                      : _buildPlaceholderImage(),

                  // Text
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resourceItem.source,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          resourceItem.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        if (resourceItem.durationOrSize.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
                              const SizedBox(width: 4),
                              Text(
                                resourceItem.durationOrSize,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Get Image
  Widget _buildPlaceholderImage() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
    );
  }
}