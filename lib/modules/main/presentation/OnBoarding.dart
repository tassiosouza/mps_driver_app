import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/main/presentation/components/CheckList.dart';
import 'package:mps_driver_app/modules/main/presentation/components/Clothes.dart';
import 'package:mps_driver_app/store/main/MainStore.dart';
import '../../../components/AppLoading.dart';
import '../../../models/Driver.dart';
import '../../../theme/app_colors.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../presentation/components/Welcome.dart';
import 'components/Book.dart';
import 'components/Video.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnBoardingState();
}

enum WhatchingStatus {
  idle,
  playing,
  done,
}

class OnBoardingState extends State<OnBoarding> {
  bool _isLoading = true;
  int _currentStep = 1;
  String _currentMessage = '';
  WhatchingStatus _videoStatus = WhatchingStatus.idle;
  late Video videoStateFullWidget;
  final _mainStore = Modular.get<MainStore>();

  void setStatus(WhatchingStatus status) {
    setState(() {
      _videoStatus = status;
    });
    log('setting state');
  }

  WhatchingStatus getVideoStatus() {
    return _videoStatus;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = false;
        _currentMessage = getCurrentMessage();
      });
    });
    videoStateFullWidget = Video(stateReference: this);
  }

  Widget getCurrentWidget() {
    switch (_currentStep) {
      case 1:
        return Welcome(_mainStore.currentDriver);
      case 2:
        return videoStateFullWidget;
      case 3:
        return const Clothes();
      case 4:
        return const Book();
      case 5:
        return const CheckList();
      default:
        log('could not load');
        return Container();
    }
  }

  String getCurrentMessage() {
    switch (_currentStep) {
      case 1:
        return 'Here you can view your optimized route and get directions to your destinations, along with interact with customers quickly and easily.';
      case 2:
        return 'Before proceeding, it is essential that you watch this video as it provides important information for all collaborators.';
      case 3:
        return 'Please make sure you are wearing the MPS dress code. Remember that you are the face of our company. Smile! Have positive & upbeat communication with the customer.';
      case 4:
        return '''Download the driver's manual book to have access to all the important instructions on how to behave and what to do when making deliveries to our customers.''';
      case 5:
        return '''Download the driver's manual book to have access to all the important instructions on how to behave and what to do when making deliveries to our customers.''';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(child: AppLoading())
            : Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 11),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 32),
                      alignment: Alignment.topRight,
                      child: Text('$_currentStep/5',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          )),
                    ),
                    Expanded(
                      flex: 6,
                      child: getCurrentWidget(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                          color: Colors.green,
                        ),
                        height: 250,
                        child: Column(children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              height: 150,
                              child: Text(
                                _currentMessage,
                                style: const TextStyle(
                                    color: Color(0xffF2F2F2), fontSize: 15),
                              )),
                          const Expanded(flex: 1, child: SizedBox(height: 0)),
                          Container(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              children: [
                                Visibility(
                                    replacement: const SizedBox(width: 100),
                                    visible: _currentStep > 1,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1.0, color: Colors.white),
                                          fixedSize: const Size(100, 40),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentStep = _currentStep - 1;
                                            _currentMessage =
                                                getCurrentMessage();
                                          });
                                        },
                                        child: const Text(
                                          'Previous',
                                          style: TextStyle(
                                              color: Color(0xffF2F2F2),
                                              fontFamily: 'Poppings'),
                                        ))),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 1.0, color: Colors.white),
                                      fixedSize: const Size(100, 40),
                                    ),
                                    onPressed: () => {getNextButtonAction()},
                                    child: getNextButtonWidget())
                              ],
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox(height: 0)),
                        ]),
                      ),
                    ),
                  ],
                )));
  }

  void getNextButtonAction() {
    if (_currentStep == 2) {
      if (_videoStatus == WhatchingStatus.done) {
        setState(() {
          _currentStep = _currentStep + 1;
          _currentMessage = getCurrentMessage();
        });
      }
    } else if (_currentStep == 5) {
      Modular.to.navigate('main/route/');
      Driver updatedDriver = _mainStore.currentDriver!.copyWith(onBoard: true);
      _mainStore.updateDriverInformation(updatedDriver);
    } else {
      setState(() {
        _currentStep = _currentStep + 1;
        _currentMessage = getCurrentMessage();
      });
    }
  }

  Widget getNextButtonWidget() {
    switch (_currentStep) {
      case 1:
      case 3:
      case 4:
        return const Text(
          'Next',
          style: TextStyle(color: Color(0xffF2F2F2), fontFamily: 'Poppings'),
        );
      case 2:
        switch (_videoStatus) {
          case WhatchingStatus.done:
            return const Text(
              'Next',
              style:
                  TextStyle(color: Color(0xffF2F2F2), fontFamily: 'Poppings'),
            );
          case WhatchingStatus.idle:
            return const Text(
              'Next',
              style: TextStyle(
                  color: Color.fromARGB(79, 254, 254, 254),
                  fontFamily: 'Poppings'),
            );
          case WhatchingStatus.playing:
            return const LinearProgressIndicator(
              color: Colors.white,
            );
        }
      case 5:
        return const Text(
          'Finish',
          style: TextStyle(color: Color(0xffF2F2F2), fontFamily: 'Poppings'),
        );
      default:
        return const Text(
          'Next',
          style: TextStyle(color: Color(0xffF2F2F2), fontFamily: 'Poppings'),
        );
    }
  }
}
