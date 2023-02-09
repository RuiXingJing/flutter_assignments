import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo({super.key, this.controller});

  final VideoPlayerController? controller;

  @override
  State<StatefulWidget> createState() => _AspectRatioVideoState();
}

class _AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(() {
      _onVideoControllerUpdate();
    });
  }

  @override
  void dispose() {
    controller!.removeListener(() {
      _onVideoControllerUpdate();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
          child: AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: VideoPlayer(controller!),
      ));
    } else {
      return Container();
    }
  }
}
