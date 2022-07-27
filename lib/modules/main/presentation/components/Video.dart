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
        'https://mps-driver-app-storage-dev50943-dev.s3.us-west-1.amazonaws.com/public/onboarding.mp4?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEHoaCXVzLXdlc3QtMSJHMEUCIQDw%2FzMBzZyZl8bC9eA0eUh0RKvyPlLLlg5ltC5zWIlerwIgSQeCvy3LUMcf0H1jrN6qsqe1UTaMydQdM2%2BWhP%2FASeEq7QIIw%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgw4NDYzNDgxODI2NzMiDAy1V4P7l9gltQ50bSrBAvB%2BqJY8Wqjsf2qVzjGEVLdc5fHUN01xrz7XRAPDBvEEKZ44jet0wA%2Fa0eqCyKzuxcgPH1pJ48GYbIC4C9dN6xJeq6owUd9nsG%2F%2BBFc1K1KPvCpWe59CO%2BcXv2iSLBLXsNzAW4EjGR%2FdF8IYUJhYtglL%2BgxWKBdXuxN7KAzjQKifXj48JgAiNFijE0DI3hrGfO%2BR9GfNiKoqzdY4%2Byc5yDBXyVdzgRhz2T6aY%2FZPKXuK%2BHACWn%2Bfhgqo4W8OQAfiFatJIsCGrFU9fFSDDXKOYnKrTRl515ji%2FES4QnJfj91af33mA%2FsLDdtSWnzvaqQvH449RTQqmR%2BW8p09L0kYfgGo78TiKHpOxy%2BRj4HY97UAmmKXJL0IG8z7S0RmRp6bUTskjaW9UTc3U3VyvyVNjS6qTCBWKxMKrHeklWxeAFk5bDCFxoCXBjqzAnCjLqpZgQJWfeERHjzQ%2FG%2FRYKWJdF%2BWx3UYE56yqUSGfUrCmhHy9%2BuH9uU25Cfp3Wn%2FuNG%2F%2BNAAGQG5fedZSDk90mZUxyYLYvY%2FDqeSeSNkpptUqqSy1ai4YLDyIKu5ILGnAll%2FuRerbG6pd5UaX2TfT3vQkRSlptbHAKEP1VnANqbLBBgRASLo7lRKGOfii0cQNJlw2KPtUpcmz6QUi36nYhrRqSg6tPoEIceQg5AmeyERRISluiufh6fDv2CBknI37JQlOuGM0p3wd%2FTp8xE3VPv%2FQqE6mbeacI2TKS8e%2BKyaCTGjFqv5eYqRhhRjjQrtD00QNc2EeivalVhURNCpKt51aAGDhyhqBkUBFAFvmzLXm%2BSpwO8G%2FZA5ZjEThtxHydRaPW%2FSihsF1v%2FOlZFM2yg%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220726T174145Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA4KDSIMSIR5RZ5PNT%2F20220726%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=4e80c18c04a5b4ca5e223e44bb383422dad4a754b24aaad7282ef729e5fbe572');
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
