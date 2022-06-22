import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mps_driver_app/Services/TwilioSmsService.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_init.dart';
import 'package:mps_driver_app/Services/TwilioService.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../components/ClientListItem.dart';
import '../../components/Loading.dart';
import '../../shared/ScreenState.dart';
import 'package:status_change/status_change.dart';

import 'MapsPage.dart';

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
        widget = StartRouteInitPage(screenViewModel);
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

  routeScreen() {
    return Scaffold(
      backgroundColor: App_Colors.white_background.value,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Text(
                          "Mark Larson  ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        DotIndicator(
                          color: App_Colors.primary_color.value,
                          size: 8,
                        )
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: Text(
                          "To check-in",
                          style: TextStyle(
                              fontSize: 14,
                              color: App_Colors.primary_color.value),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25, top: 5),
                        child: Text(
                          "Welcome message",
                          style: TextStyle(
                              fontSize: 14,
                              color: App_Colors.primary_color.value),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                  Divider(thickness: 1),
                  Divider(thickness: 1),
                ],
              ),
              Observer(
                  builder: (_) => Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Deliveries",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              GestureDetector(
                                  child: Container(
                                      padding: EdgeInsets.only(right: 25),
                                      child: Column(children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: App_Colors.primary_color.value,
                                        ),
                                        Text(
                                          "Route map",
                                          style: TextStyle(
                                              color: App_Colors
                                                  .primary_color.value),
                                        )
                                      ])),
                                  onTap: goToViewOnMap)
                            ]),
                        Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView(
                                padding: const EdgeInsets.all(8),
                                children: screenViewModel.clientList.value
                                    .map((client) => ClientItem(
                                        client,
                                        screenViewModel.clientList.value
                                            .indexOf(client)))
                                    .toList()))
                      ]))
            ],
          ),
        ),
      ),
    );
  }

  void goToViewOnMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SecondRoute(clients: screenViewModel.clientList.value)),
    );
  }
}
