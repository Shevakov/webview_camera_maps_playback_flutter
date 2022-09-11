import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image/image_list.dart';

class MyCameraWidget extends StatefulWidget {
  const MyCameraWidget({Key? key}) : super(key: key);

  @override
  State<MyCameraWidget> createState() => _MyCameraWidgetState();
}

class _MyCameraWidgetState extends State<MyCameraWidget>
    with WidgetsBindingObserver {
  late List<CameraDescription> cameras;
  CameraController? controller;
  XFile? lastImage;

  @override
  void initState() {
    super.initState();
    unawaited(initCamera());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onNewCameraSelected(cameraController.description);
    }
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.max);

    await controller!.initialize();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        controller?.value.isInitialized == true
            ? Center(
                child: CameraPreview(controller!),
              )
            : const SizedBox(),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            color: Colors.white,
            iconSize: 48,
            onPressed: () async {
              var dateNow = DateTime.now();

              String fileName =
                  '/storage/emulated/0/Pictures/${dateNow.hour}${dateNow.minute}${dateNow.second}.png';

              lastImage = await controller?.takePicture();
              lastImage?.saveTo(fileName);

              setState(() {
                _saveImage(context, fileName);
              });
            },
            icon: const Icon(Icons.camera),
          ),
        )
      ],
    );
  }

  void _saveImage(BuildContext context, String path) {
    context.read<ImageList>().setFileName(path);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });
  }
}
