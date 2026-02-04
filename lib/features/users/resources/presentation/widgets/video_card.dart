import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/users/data/resource_item.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({super.key, required this.resourceItem});

  final ResourceItem resourceItem;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      // width: 200,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail & Duration
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                color: Colors.black87,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(resourceItem.durationOrSize),
                ),
              ),
            ],
          ),
          // Text Area
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resourceItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface
                  ),
                ),
                Text(
                  resourceItem.source,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
