// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/modules/main/presentation/OnBoarding.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final OnBoardingState stateReference;
  const Video({required this.stateReference, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VideoState();
  }
}

class VideoState extends State<Video> {
  late VideoPlayerController _videoController;
  bool _onTouch = true;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _timer;
  late Timer _statusTimer;
  List<Widget> _videoStack = [];
  bool _firstPlay = true;

  @override
  void initState() {
    _videoController = VideoPlayerController.network(
        'https://mps-driver-app-storage-dev50943-dev.s3.us-west-1.amazonaws.com/public/onboarding.mp4?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEO%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMSJHMEUCIAq29YjPUfEDePmhoEtRPVgqYywWdxaov9Q%2BkCAETUtUAiEAn813r%2BznMg8kyYqqSFQo9%2Frtv01F9fvhGTLsp80xkm0q5AIISBAAGgw4NDYzNDgxODI2NzMiDLKWLswIEMe2lp%2F2virBAoXi4J76%2FlpBbWdd2fDbgSR%2FJFb4HWGLsMffiWbWKUqTOWezUIEpl9iJZ7e%2BVon2%2Box%2FRhsVja042qDAggiu8dThYuMrnTO9UVl7pfQXKUANxgSZF5DKf%2BmXZl3Bg8gATw22rPObFprR35fc5cPxdO7Nl8rVq26wfzYPCIdyjTnYYQi6YWCd%2B4%2BgJAryNhVEkHmExHZjAZloSVM%2FBVgSEjpUjftlbiSABHVja5yN%2FIL%2BrcXdmR8Z%2FNoZilUSu6%2F9xs%2BVoqNrGI%2BspXKIb3bJKIPj4URLW2H8w%2FRD5W2Yb4tvQr5HT8tr3KlpXtD50H56GPAb0Bm1sGPlDmxhbQ2Y2gE2bMvphj5wyfQvV7kitYKaBHP9L32P%2FKjefOrfYDugLOTkUNPPoMiDs%2FqSd1w1Z9uy6Fh9ohaxDHuVLv2Ek41gyjDgtJqXBjqzAq%2BJzQM8Q6GUU6diKkxvvuAoMXj3EXRcH8ROeWOpTTyOXNpx9Ww%2FbWA1cIjcY%2FMh%2BPRhzKU19pjetbwhi7E3oGL0gkS4bY9ipITKJzqyeE0%2BbIROLHsGjkNHUMKseJ5s5fiLFyFESwQ0aLhoXlS6SBJDWzkIa4cmedSIhO2rZg%2F9aImxEq2yIjI3dGhxJoOvIR4Pb%2FgKm3YIWNrjTVFX5shsGo4Zp5BCgSLHm3q6W%2BE6c3zS8fviWbLkg%2FcQ1ZXGr3Zx8XMugF%2FGlt8fCplpxQjiR%2BT1fKarBe6gyQg30x8VbdxCD6tQFTvWvL%2FKSy%2FeeL8w4c2eEz71gM6LZvghj4Mk5Lv7rEQVZCUyMm7c83JBR0QkhPglzoX36Eewcy4yazZL0twg2nCt1Zl51L00h2wu0a0%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220731T150622Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA4KDSIMSIUNOJW2G5%2F20220731%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=06cc5a428128de3869955060c4c03c167619553b97467c82f43e9dfc211e0e78');
    _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
      setState(() {});
      _timer = Timer.periodic(const Duration(milliseconds: 0), (_) {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.stateReference.setStatus(WhatchingStatus.idle);
    });
  }

  void playVideo() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        _onTouch = false;
      });
      if (widget.stateReference.getVideoStatus() == WhatchingStatus.idle) {
        widget.stateReference.setStatus(WhatchingStatus.playing);
      }
      _timer.cancel();
    });
    if (_firstPlay) {
      _statusTimer = Timer.periodic(const Duration(milliseconds: 3000), (_) {
        widget.stateReference.setStatus(WhatchingStatus.done);
        setState(() {
          _firstPlay = false;
        });
        _statusTimer.cancel();
      });
    }
  }

  void setTimeToDismissButton() {
    setState(() {
      _videoController.pause();
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _videoController.dispose();

    super.dispose();
  }

  void _swapOrder() {
    Widget _first = _videoStack[0];
    _videoStack.removeAt(0);
    _videoStack.add(_first);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              'Watch the video ',
              style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'to procced',
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ]),
          const SizedBox(height: 25),
          Expanded(
              child: Container(
                  height: 330,
                  width: 330,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/elipse.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Stack(children: [
                          Center(
                            child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: AspectRatio(
                                      aspectRatio:
                                          _videoController.value.aspectRatio,
                                      child: VideoPlayer(_videoController),
                                    ))),
                          ),
                          GestureDetector(
                              onTap: () => {setTimeToDismissButton()},
                              child: Container(
                                color: _videoController.value.isPlaying
                                    ? Colors.transparent
                                    : Color.fromARGB(1, 255, 255, 255)
                                        .withOpacity(0.5),
                                alignment: Alignment.center,
                                child: FlatButton(
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          color:
                                              _videoController.value.isPlaying
                                                  ? Colors.transparent
                                                  : Colors.white)),
                                  child: Icon(
                                    _videoController.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: _videoController.value.isPlaying
                                        ? Colors.transparent
                                        : Colors.white,
                                  ),
                                  onPressed: () => {
                                    _timer.cancel(),
                                    if (!_videoController.value.isPlaying)
                                      {playVideo()},
                                    setState(() {
                                      _videoController.value.isPlaying
                                          ? _videoController.pause()
                                          : _videoController.play();
                                    })
                                  },
                                ),
                              ))
                        ]);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ))),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
