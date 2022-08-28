// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/modules/main/presentation/OnBoarding.dart';
import 'package:video_player/video_player.dart';

import '../../../../components/AppLoading.dart';

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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
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
                          child: AppLoading(),
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
