import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatelessWidget {
  final VideoPlayerController? controller;

  const VideoItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(controller!),
            VideoProgressIndicator(controller!, allowScrubbing: true),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  controller!.value.isPlaying
                      ? Icons.pause_circle
                      : Icons.play_circle,
                  size: 36,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller!.value.isPlaying
                      ? controller!.pause()
                      : controller!.play();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
