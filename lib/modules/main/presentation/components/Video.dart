// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
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
        'https://mps-driver-app-storage-dev50943-dev.s3.us-west-1.amazonaws.com/public/onboarding.mp4?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjENr%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMSJHMEUCIQDH191w0PBVMREHhNu0y7SriwOHFMnlzwjwF8uH4mNFgQIgSUS7IIlm4TfFWkvEx2VaJlwkS%2BF6tT9r1kECdS0C13Mq5AIIMhAAGgw4NDYzNDgxODI2NzMiDMrVBx8NmFKWKK7cECrBAlcWD%2FCICS3JLbZAuQbvdi8cxfN1ofkP0pQhVZWwmuktE%2Bhfaf0bWdswDaL6KupdORUEwoIe7Gj2jhdmTtQZ4SM0%2BiAn001Puiv3iWd3tVT62riF3%2BKDbrik76Goteeyxooj8o6rI5ZJpzpOUrL4VBH3QL3ySmCUBv4ZAjH1hV7KWxWPpaijuYRIe7FxYcHOl4QdJ%2BfQTDaPePgc5yrLo1bUbjSFxr3321TPh8CQnX3noHYU4WR42f6jystrTE4mz2jW4pa1746AJequCrnkuHZ52XPd9281KhzpJYxhtuPbYyWk9DAB6YB2Vde5nT2Pe6Zz5yGq%2FEmimCkzUmgp72hRTrsw3yGAJMjIoU7kD2gYGrp4no%2FvhnecjCygj3pKCp9VvRVM4LsXdljNcrrsq%2BudTs6BD47mUi8Wb8wxbIHVaDD50JWXBjqzAnDoyy%2BJvcs9o%2B8NS9xGcDj8%2BXV6qhZfZkkLMXBu%2F2Y49hNWIbMI8mX6Q%2Fg%2Bow8R%2FNqvLPT36g1bPHfMI65cqlNBMqmyeq1mO7YY3AsPrUtDG2wxlTlDjZqZ%2F2LDil5eWB%2B%2FA2iPpSv6pir4%2Fo5OFUlHg%2FtADEc5feY5fMYqfXR9n6DwEUrQ%2BSD6lRKOIAZYzQTEXMXIe%2FbPyXtQBHtbGzXK3jfrvDWnOk1xH7GWkv4M2hXeJxoZnr6zBiB2D%2FtPog717EDCv9nlHpVY9W0AoJ12IqdesY7K6ZjiD3C7Fm23JIJSVXSy3rN520MO0izDlw59aI1x%2BViMgOn8IETGYXGPOk7CwWcJIoXO4yp0Ic70erFWMO5ynK4VmvChOLwXd0p5kPaUsJ44L3SIS6WK0R7pkGg%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220730T172138Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA4KDSIMSIX6ENUTLQ%2F20220730%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=ef7309e1f178435c3f27a750e44ff77e627f5c9cccdae09231bf3da2f0f7b446');
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
