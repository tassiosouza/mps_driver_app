import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/Driver.dart';
import 'package:mps_driver_app/modules/route/presentation/init/StartRoutePage.dart';
import 'package:intl/intl.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import 'package:mps_driver_app/modules/route/presentation/route/start_route_viewmodel.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../../../Services/DriverService.dart';
import '../../../../components/AppDialogs.dart';
import '../components/ClientListItem.dart';
import '../components/StateRouteLoading.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as Stepper;

import '../map/MapsPage.dart';

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
  StartRouteViewModel screenViewModel = Modular.get<StartRouteViewModel>();
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
        "Make your checkin and then click welcome message to send message to the clients.");
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
      case RoutePageState.init:
        widget = StartRouteInitPage();
        break;
      case RoutePageState.loading:
        widget = StateRouteLoading();
        break;
      case RoutePageState.routePlan:
        if (screenViewModel.firstOpen.value) {
          Future.delayed(Duration.zero, () => welcomeDialog());
        }
        widget = routeScreen();
        break;
      case RoutePageState.routeDone:
        Future.delayed(Duration.zero, () => finishRouteDialog());
        widget = StartRouteInitPage();
        break;
      case RoutePageState.bagsChecking:
        widget = routeScreen();
        break;
      case RoutePageState.inTransit:
        Future.delayed(Duration.zero, () => inTransitDialog());
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

  Future<void> welcomeMessageSendConfirmDialog() {
    return AppDialogs().showConfirmDialog(
        context,
        () => {screenViewModel.goToBagsScreen(_currentDriver!)},
        "Confirm",
        "Touch in Check-in to make your checking and touch welcome message to send message to clients");
  }

  Widget toCheckIn(bool checkin) {
    if (checkin) {
      DateTime now = DateTime.now();
      String time = DateFormat('kk:mm').format(now);
      return Container(
          padding: EdgeInsets.only(left: 18, top: 5),
          child: Text(
            "Initiated at: $time",
            style: TextStyle(fontSize: 14, color: App_Colors.grey_dark.value),
          ),
          alignment: Alignment.centerLeft);
    } else {
      return GestureDetector(
          onTap: () => screenViewModel.setCheckIn(),
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
                              toCheckIn(screenViewModel.checkin.value)),
                      getWelcomeMessage(
                          screenViewModel.sentWelcomeMessage.value)
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
                        builder: (_) => ListView(
                            padding: const EdgeInsets.all(8),
                            children: screenViewModel.clientList
                                .map((client) => ClientItem(
                                    client,
                                    screenViewModel.clientList.indexOf(client),
                                    _currentDriver!))
                                .toList())))
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
