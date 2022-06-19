import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mps_driver_app/Services/TwilioSmsService.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../components/client_item.dart';
import '../../components/loading.dart';
import '../../shared/ScreenState.dart';
import 'package:status_change/status_change.dart';

import 'second_route.dart';

class StartRoutePage extends StatelessWidget {
  const StartRoutePage();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Start Route',
      home: StartRouteComponent(),
    );
  }
}

class StartRouteComponent extends StatefulWidget {
  const StartRouteComponent();
  @override
  _StartRouteComponentState createState() => _StartRouteComponentState();
}

class _StartRouteComponentState extends State<StartRouteComponent> {
  final screenViewModel = StartRouteViewModel();

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => getStateScreen(screenViewModel.screenState.value));
  }

  Widget getStateScreen(ScreenState screenState) {
    late Widget widget;
    switch (screenState) {
      case ScreenState.init:
        widget = init();
        break;
      case ScreenState.loading:
        widget = Loading();
        break;
      case ScreenState.success:
        widget = routeScreen();
        break;
      case ScreenState.error:
        break;
    }
    return widget;
  }

  init() {
    return Material(
      child: Center(
        child: TextButton(
          onPressed: () {
            screenViewModel.getClientList();
            screenViewModel.goToLoadingScreen();
          },
          child: Text(
            "Start route",
            style: TextStyle(color: App_Colors.primary_color.value),
          ),
        ),
      ),
    );
  }

  routeScreen() {
    return Scaffold(
      backgroundColor: App_Colors.white_background.value,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Text("Mark Larson"),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Text("check-in: "),
                        alignment: Alignment.centerLeft,
                      ),
                      Text("07:34")
                    ],
                  ),
                  Divider(thickness: 1),
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Text("Status Route"),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              Observer(
                  builder: (_) => Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: ListView(
                                  padding: const EdgeInsets.all(8),
                                  children: screenViewModel.clientList.value
                                      .map((client) => ClientItem(
                                          client,
                                          () => TwilioSmsService().sendSms(
                                              client.name, client.eta)))
                                      .toList())),
                          Container(
                              child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute(
                                        clients:
                                            screenViewModel.clientList.value)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                primary: App_Colors.primary_color.value),
                            child: Row(children: const [
                              Text("Start",
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Poppins')),
                              SizedBox(width: 10),
                              Icon(CustomIcon.start_driver_icon, size: 10)
                            ]),
                          )),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
