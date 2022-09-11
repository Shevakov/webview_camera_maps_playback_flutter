import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controls.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://adfox-content.s3.yandex.net/video_source/220906/adfox/2048596/5645976_1.49de4ef576879fb7208bb3e6e3668399.mp4')
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _videoController.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(_videoController),
                      Controls(controller: _videoController),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
