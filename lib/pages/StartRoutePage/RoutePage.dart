import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mps_driver_app/pages/StartRoutePage/StartRoutePage.dart';
import 'package:mps_driver_app/Services/TwilioService.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:intl/intl.dart';
import 'package:mps_driver_app/pages/StartRoutePage/StartRoutePageState.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../components/AppDialogs.dart';
import '../../components/ClientListItem.dart';
import '../../components/Loading.dart';
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
  int dotCount = 4;
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => getStateScreen(screenViewModel.screenState.value));
  }

  Future<void> welcomeDialog(){
    return AppDialogs().showDialogJustMsg(context, "Welcome Driver",
        "Make your checkin and then click welcome message to send message to the clients.");
  }

  Widget getStateScreen(RoutePageState screenState) {
    late Widget widget;
    switch (screenState) {
      case RoutePageState.init:
        widget = StartRouteInitPage(screenViewModel);
        break;
      case RoutePageState.loading:
        widget = Loading();
        break;
      case RoutePageState.routePlan:
        Future.delayed(Duration.zero, () => welcomeDialog());
        widget = routeScreen();
        break;
      case RoutePageState.bagsChecking:
      case RoutePageState.inTransit:
      case RoutePageState.routeDone:
        widget = routeScreen();
        break;
      case RoutePageState.error:
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

  Future<void> welcomeMessageSendConfirm(){
    return AppDialogs().showDialogConfirm(context, screenViewModel, "Confirm",
        "Touch in Check-in to make your checking and touch welcome message to send message to clients");
  }

  Widget toCheckIn(bool checkin){
    if(checkin){
      DateTime now = DateTime.now();
      String time = DateFormat('kk:mm').format(now);
      return Container(padding: EdgeInsets.only(left: 18, top: 5),
        child: Text("Initiated at: $time", style: TextStyle(fontSize: 14,
            color: App_Colors.grey_dark.value),
        ), alignment: Alignment.centerLeft);
    } else {
      return GestureDetector(onTap: () => screenViewModel.setCheckIn(),
          child: Container(padding: EdgeInsets.only(left: 18, top: 5),
            child: Text("Check-in", style: TextStyle(fontSize: 14,
                color: App_Colors.primary_color.value),
            ), alignment: Alignment.centerLeft
          ));
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
              Column(children: [
                  SizedBox(height: 60,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 18),
                    child: Row(children: [
                        Text("Mark Larson  ", style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        DotIndicator(color: App_Colors.primary_color.value,
                          size: 8,)
                      ],),
                    alignment: Alignment.centerLeft),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Observer(builder: (_) => toCheckIn(screenViewModel.checkin.value)),
                      GestureDetector(child: Container(padding: EdgeInsets.only(right: 25, top: 5),
                        child: Text("Welcome message",
                          style: TextStyle(fontSize: 14,
                              color: App_Colors.primary_color.value),
                        ),
                        alignment: Alignment.centerLeft,
                      ), onTap: welcomeMessageSendConfirm)
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 1),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(children: [ Text("Route Status",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: "Poppins", fontSize: 16))
                    ]),
                  ),
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
                    activeStep: screenViewModel.statusRouteBar.value,

                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) {
                      setState(() {
                        screenViewModel.statusRouteBar.value = index;
                      });
                    },
                  ),
                  SizedBox(height: 10
                  ),
                  Row(children: [Expanded(
                          child: Text(
                        "Route Plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: getStatusColor(0, screenViewModel.statusRouteBar.value)),
                      )),
                      Expanded(
                          child: Text(
                        "Bags checking",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: getStatusColor(1, screenViewModel.statusRouteBar.value)),
                      )),
                      Expanded(
                          child: Text("In transit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: getStatusColor(2, screenViewModel.statusRouteBar.value)))),
                      Expanded(
                          child: Text("Route done",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: getStatusColor(3, screenViewModel.statusRouteBar.value)))),
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 1),
                ],
              ),
              Column(children: [
                SizedBox(height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.only(left: 18),
                        child: Text("Deliveries",
                          style: TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      GestureDetector(child: Container(
                              padding: EdgeInsets.only(right: 25),
                              child: Column(children: [
                                Icon(Icons.location_on_outlined,
                                  color: App_Colors.primary_color.value,
                                ),
                                Text("Route map", style: TextStyle(
                                  color: App_Colors.primary_color.value),
                                )])),
                          onTap: goToViewOnMap)
                    ]),
                  Container(height: MediaQuery.of(context).size.height/2.1,
                    child: Observer(builder: (_) => ListView(padding: const EdgeInsets.all(8),
                        children: screenViewModel.clientList
                            .map((client) => ClientItem(client,
                            screenViewModel, screenViewModel.clientList
                                .indexOf(client))).toList())))
                      ]),
            ])
        ),
      ),
    );
  }

  void goToViewOnMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SecondRoute(clients: screenViewModel.clientList)),
    );
  }
}