// ignore_for_file: depend_on_referenced_packages, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../route/presentation/RouteViewModel.dart';

class MainLoading extends StatefulWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainLoadingState();
}

class MainLoadingState extends State<MainLoading> {
  late var hubSubscription;
  final _routeViewModel = Modular.get<RouteViewModel>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _routeViewModel.syncAmplifyData();
      hubSubscription = Amplify.Hub.listen([HubChannel.DataStore], (msg) async {
        if (msg.eventName == "ready") {
          await _routeViewModel.fetchCurrentDriver();
          String nextPage = _routeViewModel.currentDriver!.onBoard == true
              ? '/main'
              : '/onboarding';
          Modular.to.navigate(nextPage);
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
