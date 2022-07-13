import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/Driver.dart';
import 'package:mps_driver_app/modules/route/presentation/InitRoutePage.dart';
import 'package:intl/intl.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import 'package:mps_driver_app/modules/route/presentation/route_viewmodel.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../../Services/DriverService.dart';
import '../../../components/AppDialogs.dart';
import 'components/ClientsListView.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as Stepper;

import 'MapsPage.dart';

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateRoutePage();
}

class StateRoutePage extends State<RoutePage> {
  RouteViewModel screenViewModel = Modular.get<RouteViewModel>();
  int dotCount = 4;
  Driver? _currentDriver;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDriverInformation();
    });
    super.initState();
  }

  void loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    setState(() {
      _currentDriver = driver;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => getStateScreen(screenViewModel.screenState.value));
  }

  Future<void> welcomeDialog() {
    screenViewModel.setFirstOpen();
    return AppDialogs().showDialogJustMsg(context, "Welcome Driver",
        "Make your checkin and start to check bags.");
  }

  Future<void> welcomeMessageSendConfirmDialog() {
    return AppDialogs().showConfirmDialog(
        context, () => {screenViewModel.goToInTransitScreen(_currentDriver!)},
        "Confirm",
        "Touch in Check-in to make your checking and touch welcome message to send message to clients");
  }

  Future<void> inTransitDialog() {
    return AppDialogs().showDialogJustMsg(context, "In Transit",
        "You checked your bags and you can delivery now.");
  }

  Future<void> finishRouteDialog() {
    return AppDialogs()
        .showDialogJustMsg(context, "Route Done", "You finish your route.");
  }

  Widget getStateScreen(RoutePageState screenState) {
    late Widget widget;
    switch (screenState) {
      case RoutePageState.routePlan:
        if (screenViewModel.firstOpen.value) {
          Future.delayed(Duration.zero, () => welcomeDialog());
        }
        widget = routeScreen();
        break;
      case RoutePageState.routeDone:
        Future.delayed(Duration.zero, () => finishRouteDialog());
        widget = InitRoutePage();
        break;
      case RoutePageState.bagsChecking:
        widget = routeScreen();
        break;
      case RoutePageState.inTransit:
        widget = routeScreen();
        break;
      case RoutePageState.welcomeMessage:
        widget = routeScreen();
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

  Widget toCheckIn(bool madeCheckIn) {
    if (madeCheckIn) {
      if(screenViewModel.checkingTime.value == ''){
        DateTime now = DateTime.now();
        String time = DateFormat('kk:mm').format(now);
        screenViewModel.setCheckingTime(time);
      }
      return Container(
          padding: EdgeInsets.only(left: 18, top: 5),
          child: Text(
            "Initiated at: ${screenViewModel.checkingTime.value}",
            style: TextStyle(fontSize: 14, color: App_Colors.grey_dark.value),
          ),
          alignment: Alignment.centerLeft);
    } else {
      return GestureDetector(
          onTap: (){
            screenViewModel.goToBagsScreen();
          },
          child: Container(
              padding: EdgeInsets.only(left: 18, top: 5),
              child: Text(
                "Check-in",
                style: TextStyle(
                    fontSize: 14, color: App_Colors.primary_color.value),
              ),
              alignment: Alignment.centerLeft));
    }
  }

  Widget getWelcomeMessage(bool sentWelcomeMessage) {
    if (sentWelcomeMessage) {
      return Container(
        padding: EdgeInsets.only(right: 25, top: 5),
        child: Text(
          "message sent",
          style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value),
        ),
        alignment: Alignment.centerLeft,
      );
    } else {
      return GestureDetector(
          child: Container(
            padding: EdgeInsets.only(right: 25, top: 5),
            child: Text(
              "Welcome message",
              style: TextStyle(
                  fontSize: 14, color: App_Colors.primary_color.value),
            ),
            alignment: Alignment.centerLeft,
          ),
          onTap: welcomeMessageSendConfirmDialog);
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
                          _currentDriver != null
                              ? Text(
                                  "${_currentDriver?.name}  ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(""),
                          DotIndicator(
                            color: App_Colors.primary_color.value,
                            size: 8,
                          )
                        ],
                      ),
                      alignment: Alignment.centerLeft),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Observer(
                        builder: (_) =>
                          toCheckIn(screenViewModel.screenState.value != RoutePageState.routePlan)),
                      getWelcomeMessage(true)
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Route Plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: getStatusColor(
                                0, screenViewModel.statusRouteBar.value)),
                      )),
                      Expanded(
                          child: Text(
                        "Bags checking",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: getStatusColor(
                                1, screenViewModel.statusRouteBar.value)),
                      )),
                      Expanded(
                          child: Text("In transit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: getStatusColor(2,
                                      screenViewModel.statusRouteBar.value)))),
                      Expanded(
                          child: Text("Route done",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: getStatusColor(3,
                                      screenViewModel.statusRouteBar.value)))),
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 1),
                ],
              ),
              Column(children: [
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
                              fontWeight: FontWeight.w500, fontSize: 16),
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
                                      color: App_Colors.primary_color.value),
                                )
                              ])),
                          onTap: goToViewOnMap)
                    ]),
                Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    child: Observer(
                        builder: (_) {
                          if(_currentDriver != null){
                            return ClientsListView(_currentDriver!);
                          }
                          return Center();
                          }))
              ]),
            ])),
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
