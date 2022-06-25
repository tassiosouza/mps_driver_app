import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mps_driver_app/pages/StartRoutePage/StartRoutePage.dart';
import 'package:mps_driver_app/Services/TwilioService.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../components/AppDialogs.dart';
import '../../components/ClientListItem.dart';
import '../../components/Loading.dart';
import '../../shared/ScreenState.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as Stepper;

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
  int activeStep = 0;
  int dotCount = 4;
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

  Color getStatusColor(int itemIndex, currentIndex) {
    if (currentIndex < itemIndex) {
      return Colors.grey;
    } else if (currentIndex == itemIndex) {
      return Colors.black;
    } else {
      return Colors.green;
    }
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
                    padding: EdgeInsets.only(left: 18),
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
                        padding: EdgeInsets.only(left: 18, top: 5),
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
                  SizedBox(height: 15),
                  Divider(thickness: 1),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(children: [
                      Text("Route Status",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: "Poppins", fontSize: 16))
                    ]),
                  ),
                  TextButton(
                      onPressed: () => AppDialogs()
                          .showDialogJustMsg(context, "title", "body"),
                      child: Text("show dialog")),
                  SizedBox(height: 15),
                  Stepper.IconStepper(
                    scrollingDisabled: true,
                    enableNextPreviousButtons: false,
                    icons: [
                      Icon(
                        Icons.supervised_user_circle,
                        color: Colors.green,
                      ),
                      Icon(
                        Icons.supervised_user_circle,
                        color: Colors.green,
                      ),
                      Icon(
                        Icons.supervised_user_circle,
                        color: Colors.green,
                      ),
                      Icon(
                        Icons.supervised_user_circle,
                        color: Colors.green,
                      ),
                    ],

                    activeStepBorderColor: Colors.green,
                    activeStepBorderWidth: 1,
                    stepRadius: 3,
                    lineColor: Colors.green,
                    lineLength: 85,
                    activeStepBorderPadding: 2,

                    // activeStep property set to activeStep variable defined above.
                    activeStep: activeStep,

                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) {
                      setState(() {
                        activeStep = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Route Plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: getStatusColor(0, activeStep)),
                      )),
                      Expanded(
                          child: Text(
                        "Bags checking",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: getStatusColor(1, activeStep)),
                      )),
                      Expanded(
                          child: Text("In transit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: getStatusColor(2, activeStep)))),
                      Expanded(
                          child: Text("Route done",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: getStatusColor(3, activeStep)))),
                    ],
                  ),
                  SizedBox(height: 15),
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
                                padding: EdgeInsets.only(left: 18),
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

// Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
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
