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
        'https://mps-driver-app-storage-dev50943-dev.s3.us-west-1.amazonaws.com/public/onboarding.mp4?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKj%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMSJHMEUCIER8MNZoOpzif3pSdLqRYc0yiJkiD4UeZROhI4Er0ZnEAiEAm78t0MatNQVX%2BEpaastNwf95O6T%2FwHK9qQxhrEgU9dkq7QII8f%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgw4NDYzNDgxODI2NzMiDIlhBUdQCtEFAVbHECrBAvM83zjiFCl8AaxxRZI0ALXVH7l9rLiGyiHX6AhyFOgtqVzaf73h54%2BdURjoMSM9KtiYt0t%2BDIPS%2BLQsTgKpImJG3OvTLT8G6qNiawOiJSlNwTQysTScNERTUb%2FwR1eqqTbXf2YiqFBvEvGIRjBB1MuawE8tUW2cnxTFndqGC%2FI42yFFrSMNreIDL7sRnI6VJq6rkfPdFQIIMNTtG6Ks9Ba2C9RoyRUuzgY2XQZcq8GyFYeXGIugaEk7uHKS42t%2BEgZwQKiGrfXnh5BBrDMx9jaI6wOGU06uu80j5E9cf5NkdTI036Rj00J3MUv2aqaTuWVGkRRZDvgLx7gJJj6jsAuwsuKb8cm%2FcfWUPFtEF%2FETHm1SsT5%2FtSJ8pCWfgf7iRNi8BhDqvQqKB4Y6b9V1Fk%2BCpur6DVUC3Ahn2nDB7r8IqzDM2IqXBjqzAqXo0ht1iPtd5ASUupNKvt%2F0QNLxW%2Fz83I33vIOZHSuvjQB9itdgCvJRHSYKMEFZ77yrNzzwFATksgBBH0zqvhSjhrEL7g%2Fxaaob3FtxJkUqFNjFQTJixQLl9CnWivai0QbVY%2By8xRCL9Jt2QRMwytN6zn%2FVV4txU%2F5PaM4bsHBt%2FWmhDGU2Vx922BLLKmFu27WQ4Ic9ANw96kruB2T3ABtgCzo%2FGvXtvO9xpDw7wXrDkHKYR27%2BSVYEi6tskJKS4qOX6gHXVl5Uvb1adnNt2k2p8l1nrxyuNsg%2BFaYpIRR19U1XwqOL17a%2BzzAtuBYTsTs%2F9oeYo14vzfs%2B58R92sz94BgL72qvs1FN%2FF13Sh%2B%2BgpWYE%2B9mgYlChLFDW6F0SW1FtYwZ5AhbC4F1Gtv%2B%2FkzjgzQ%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220728T161351Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA4KDSIMSIVPN2TG5B%2F20220728%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=67e3c84dd3478e96c2d27c7297d4a39c98eb49f9dfc9a977d967f882976e1e77');
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
