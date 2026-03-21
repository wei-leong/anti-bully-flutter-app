import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.resourceItem});

  final ResourceItem resourceItem;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late YoutubePlayerController _controller;
  @override
  void initState(){
    super.initState();

    final String videoURL = widget.resourceItem.content?['video_url_(youtube_only)'] ?? "";

    final String? videoId = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              widget.resourceItem.source.isNotEmpty ? widget.resourceItem.source[0] : "?",
              style: TextStyle(color: colorScheme.onPrimaryContainer),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.resourceItem.source,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.resourceItem.title,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    onReady: () {
                      debugPrint('YouTube Player is ready.');
                    },
                  ),
                ),
                
                const SizedBox(height: 8),
                // Show Time
                if (widget.resourceItem.durationOrSize.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.resourceItem.durationOrSize,
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.primary),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
