import 'package:apu_assignment/app.dart';
import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:apu_assignment/features/users/resources/presentation/screens/full_screen_video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed to force screen orientation
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.resourceItem});

  final ResourceItem resourceItem;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late YoutubePlayerController _controller;
  bool _isYoutubeValid = false;
  String? _videoId;

  @override
  void initState() {
    super.initState();
    final String videoURL =
        widget.resourceItem.content?['video_url_(youtube_only)'] ?? "";
    _videoId = YoutubePlayer.convertUrlToId(videoURL);

    if (_videoId != null && _videoId!.isNotEmpty) {
      _isYoutubeValid = true;
      _controller = YoutubePlayerController(
        initialVideoId: _videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: false, // MUST be false inside a list!
          mute: false,
          isLive: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    if (_isYoutubeValid) {
      _controller.dispose();
    }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // YouTube Player (Inline without the buggy Builder)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _isYoutubeValid
                ? YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: colorScheme.primary,
                    // --- NEW: Custom Bottom Actions to fix the crash ---
                    bottomActions: [
                      const CurrentPosition(),
                      const SizedBox(width: 8.0),
                      ProgressBar(
                        isExpanded: true,
                        colors: ProgressBarColors(
                          playedColor: colorScheme.primary,
                          handleColor: colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                        onPressed: () {
                          // 1. Pause the small video
                          _controller.pause(); 
                          
                          // 2. Push the dedicated fullscreen page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenVideoPage(
                                videoId: _videoId!,
                              ),
                            ),
                          ).then((_) {
                            // 3. Force the phone back to portrait mode when they exit!
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);
                          });
                        },
                      ),
                    ],
                  )
                : Container(
                    color: Colors.black87,
                    child: const Center(
                      child: Text(
                        "Invalid Video Link",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
          ),
          
          // Text Area (Kept exactly as you styled it)
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.resourceItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  widget.resourceItem.source,
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