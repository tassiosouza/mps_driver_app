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
        'https://mps-driver-app-storage-dev50943-dev.s3.us-west-1.amazonaws.com/public/onboarding.mp4?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMSJIMEYCIQDAcTzEhmMP1J77dEbcSEbsh5SVB7KNbnBCQ19zuu%2BsIQIhAO2JsHzN3lvIlp%2FY%2BxL2hf%2FL2PHB38Z3LAnoMLYEkW%2FPKu0CCN7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMODQ2MzQ4MTgyNjczIgwbTwxL6aMMQeNbifYqwQLUw7uluFSgyjETh1OLMbCn7Rmzc5wMiQ2gj%2F379OQoKTW7vgxlMMi8tLOz3pIFjxdc7o%2B48UZwhkD%2BUA5x20FkrQhTbogi%2FDn9rgY0%2FiM%2FK9%2BuEv2K7bMdtnAkffqTUD%2BdAw92P%2F%2BgMBTm%2B8mhuKrosUTtMjHFYUR9Y%2Fj16pThFXBqhhK7oFF0kJSfL3uUb8wHYmWrk31CvHrCb7ja5qhFBe9QamiClh%2BhlRflZlOKR%2B3zf2TSQCIGxyrankaWJQAESwOoARGTrFDZWQJnOb7STZGpf9OuEMdV8IAGu90EdvcM0rRx2CgIrieqoRRTDNTLfeM0xyIOyUrfBugMlWi%2B0I5l53wQmbvHHvLDzJXV1nD7I5xnof0r1okazOYvoUWwsEK1GbnPKuh9v6zXzrvSc5xC8Q33Dx3PYC7pX8lll50w5LmFlwY6sgJD8Inzyl%2Fu0hJwm0eqrVBBpUJ0Tq%2F%2BtE86JZr4JGRiJ0LvkAU1SgVYI6zIGOvSzxai49DnP%2FnafK%2B%2FXvVspU%2BpW13yMEdrH7tBC8lDkKDdr2tksGmVV9Xzh2jRsFuKZITH%2FkE79vjtb3DDOnz1OMcyHBE8bJHcizih7z%2FxnYJjCUOk%2B6iEjN2q310j6kyEHO6n889V4z9GtvdR0N4tgIZu71A0zxpsQ0zr9PR0nlLmdTDRI5v0bAFbKNBZAfznfJawqSfDgq5vTlIFfDNTI0f%2BoicT%2FBQ868EwbofC%2BioX02g%2B7Ep1gA5gs5fiAocv3GP4PwIedKcBLIJ%2FOTrSx2%2BReh62qctfwWcZp7AAPVpw%2FSnH2YDE5OGDRtkJbgqeeRanMxOu%2FZTWCOcNkJaEivxUXoI%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220727T211313Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA4KDSIMSIVV3DWGCV%2F20220727%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=d27a846355ea260deac47ca61cad16ba18c2d6c0e0309f3344e88e68b0c438fa');
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
