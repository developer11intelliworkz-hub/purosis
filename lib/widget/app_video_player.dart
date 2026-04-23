import 'package:flutter/material.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? title;

  const AppVideoPlayer({super.key, required this.videoUrl, this.title});

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController _controller;

  bool showControls = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() => showControls = true); // show header again
    } else {
      _controller.play();
      setState(() => showControls = false); // hide header

      /// auto hide controls after 2 sec
      Future.delayed(const Duration(seconds: 2), () {
        if (_controller.value.isPlaying) {
          setState(() => showControls = false);
        }
      });
    }
  }

  void toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      /// ✅ HEADER (AUTO HIDE)
      appBar: showControls
          ? AppBar(
              backgroundColor: Colors.black.withOpacity(0.3),
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(widget.title ?? "Video Player"),
            )
          : null,

      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: toggleControls,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),

                    /// ▶️ Play/Pause
                    if (showControls)
                      GestureDetector(
                        onTap: togglePlayPause,
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),

                    /// ⏱ Bottom Controls
                    if (showControls)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.red,
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.white24,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDuration(_controller.value.position),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    formatDuration(_controller.value.duration),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            : CommonWidget.commonLoading(),
      ),
    );
  }
}
