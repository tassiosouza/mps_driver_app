// ignore_for_file: depend_on_referenced_packages, unused_local_variable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../components/AppLoading.dart';
import '../../../models/Driver.dart';
import '../../../store/main/MainStore.dart';

class MainLoading extends StatefulWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainLoadingState();
}

class MainLoadingState extends State<MainLoading> {
  final _mainStore = Modular.get<MainStore>();
  late Driver driver;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ** Load Driver Information
      if (_mainStore.currentDriver == null) {
        await _mainStore.retrieveDriverInformation();
      }

      if (_mainStore.error != '') {
        // ** TODO: Implement Error Screen
      } else {
        driver = _mainStore.currentDriver!;
      }

      String nextPage =
          _mainStore.currentDriver!.onBoard == true ? '/main' : '/onboarding';
      Modular.to.navigate(nextPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AppLoading()));
  }
}
