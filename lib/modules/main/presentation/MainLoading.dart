// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class MainLoading extends StatefulWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainLoadingState();
}

class MainLoadingState extends State<MainLoading> {
  late var hubSubscription;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('entering main loading again');
      await Amplify.DataStore.stop();
      await Amplify.DataStore.start();
      hubSubscription = Amplify.Hub.listen([HubChannel.DataStore], (msg) {
        log('hub subscription event status: ${msg.eventName}');
        if (msg.eventName == "ready") {
          log('first');
          Modular.to.navigate('/onboarding');
          hubSubscription = null;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
