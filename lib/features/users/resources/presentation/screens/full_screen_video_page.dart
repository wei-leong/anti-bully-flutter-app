// Dedicated Fullscreen Page to prevent ScrollController crashes
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenVideoPage extends StatefulWidget {
  final String videoId;
  const FullScreenVideoPage({super.key, required this.videoId});

  @override
  State<FullScreenVideoPage> createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late YoutubePlayerController _fsController;

  @override
  void initState() {
    super.initState();
    
    // 1. Force the phone into Landscape mode the moment this page opens
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _fsController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, 
        mute: false,
        // Hides the default youtube top bar so our back button looks clean
        hideControls: false, 
      ),
    );
  }

  @override
  void dispose() {
    // 2. Force the phone back into Portrait mode when they press back!
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    _fsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // SafeArea prevents the video from going under the iPhone notch / Android camera hole
      body: SafeArea(
        child: Center(
          child: YoutubePlayer(
            controller: _fsController,
            showVideoProgressIndicator: true,
            // --- NEW: Add the Back Button directly inside the video player! ---
            topActions: [
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded, 
                  color: Colors.white, 
                  size: 24.0,
                ),
                onPressed: () {
                  // This pops the page and triggers the dispose() method to rotate the screen back
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}