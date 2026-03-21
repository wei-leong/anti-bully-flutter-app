import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class VideoCard extends StatelessWidget {
  const VideoCard({super.key, required this.resourceItem});

  final ResourceItem resourceItem;

  String? _extractYoutubeId(String url) {
    final RegExp regExp = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  String _getYoutubeThumbnail(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final videoUrl = resourceItem.content?['video_url_(youtube_only)'] ?? '';
    final videoId = _extractYoutubeId(videoUrl);
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
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (videoId != null)
                  Image.network(
                    _getYoutubeThumbnail(videoId),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.black87),
                  )
                else
                  Container(color: Colors.black87),
                InkWell(
                  onTap: () async {
                    if (videoUrl.isNotEmpty) {
                      final uri = Uri.parse(videoUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Could not open video"),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Container(
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
                ),
                // Positioned(
                //   bottom: 8,
                //   right: 8,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 4),
                //     decoration: BoxDecoration(
                //       color: colorScheme.onPrimaryContainer,
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child: Text(resourceItem.durationOrSize),
                //   ),
                // ),
              ],
            ),
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
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  resourceItem.source,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
