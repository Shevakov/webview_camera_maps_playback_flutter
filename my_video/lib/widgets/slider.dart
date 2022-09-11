import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSlider extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoSlider({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  VideoSliderState createState() => VideoSliderState();
}

class VideoSliderState extends State<VideoSlider> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller.value.isInitialized) {
      final int duration = widget.controller.value.duration.inMilliseconds;
      final int position = widget.controller.value.position.inMilliseconds;

      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 32,
            child: Slider.adaptive(
              value: position / duration,
              activeColor: Colors.cyanAccent,
              onChanged: (double value) => widget.controller
                  .seekTo(widget.controller.value.duration * value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(widget.controller.value.position),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  formatDuration(widget.controller.value.duration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  static String formatDuration(Duration d) {
    return d.toString().split('.')[0];
  }
}
