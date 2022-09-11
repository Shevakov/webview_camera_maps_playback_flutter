import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_video/widgets/slider.dart';
import 'package:video_player/video_player.dart';

class Controls extends StatefulWidget {
  final VideoPlayerController controller;

  const Controls({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  ControlsState createState() => ControlsState();
}

class ControlsState extends State<Controls> {
  bool isPlaying = true;
  bool controlsShown = false;

  Duration _delay(int after) => Duration(seconds: after);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (_) => _handleTap(),
      onTapDown: (_) => _handleTap(),
      child: Visibility(
        visible: controlsShown,
        replacement: const SizedBox.expand(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoSlider(controller: widget.controller),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _rewindVideo(-10),
                    icon: const Icon(
                      Icons.replay_10,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipOval(
                    child: InkWell(
                      onTap: _handlePause,
                      child: Container(
                        color: Colors.white,
                        width: 70,
                        height: 70,
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _rewindVideo(10),
                    icon: const Icon(
                      Icons.forward_10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    setState(() {
      controlsShown = !controlsShown;
    });
    Future.delayed(_delay(3), () {
      if (isPlaying) {
        _hideControls();
      }
    });
  }

  void _handlePause() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      widget.controller.play();
      setState(() {
        isPlaying = true;
      });
      _hideControls();
    }
  }

  void _hideControls() {
    if (controlsShown) {
      Timer(_delay(4), () {
        setState(() => controlsShown = false);
      });
    }
  }

  void _rewindVideo(int seconds) {
    widget.controller.seekTo(
      Duration(seconds: widget.controller.value.position.inSeconds + seconds),
    );
    _hideControls();
  }
}
