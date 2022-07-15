import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/Driver.dart';
import 'package:intl/intl.dart';
import 'package:mps_driver_app/modules/route/RouteModule.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import 'package:mps_driver_app/modules/route/presentation/route_viewmodel.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../../Services/DriverService.dart';
import '../../../components/AppDialogs.dart';
import '../../../models/RouteStatus.dart';
import 'components/OrdersListView.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as Stepper;
import '../../../models/Route.dart' as RouteModel;
import 'MapsPage.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateRoutePage();
}

class StateRoutePage extends State<RoutePage> {
  RouteViewModel screenViewModel = Modular.get<RouteViewModel>();
  int dotCount = 4;
  Driver? _currentDriver;
  RouteModel.Route? _currentRoute;
  late StreamSubscription<QuerySnapshot<RouteModel.Route>> _subscription;

  @override
  void initState() {
    Driver? driver;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      driver = await loadDriverInformation();

      _subscription = Amplify.DataStore.observeQuery(RouteModel.Route.classType,
              where: RouteModel.Route.ROUTEDRIVERID.eq(driver?.getId()))
          .listen((QuerySnapshot<RouteModel.Route> snapshot) {
        List<RouteModel.Route> routes = snapshot.items;
        RouteModel.Route currentRouteUpdate;
        if (_currentRoute != null) {
          currentRouteUpdate = routes
              .where((route) => route.id == _currentRoute?.id)
              .toList()[0];

          if (currentRouteUpdate.status == RouteStatus.DONE ||
              currentRouteUpdate.status == RouteStatus.ABORTED) {
            screenViewModel.setIsInRoute(false);
            Modular.to.navigate('./');
          } else {
            setState(() {
              _currentRoute = currentRouteUpdate;
            });
            log("the current route has been update");
          }
        } else {
          for (RouteModel.Route route in routes) {
            if (route.status != RouteStatus.DONE &&
                route.status != RouteStatus.ABORTED) {
              setState(() {
                _currentRoute = route;
              });
            }
          }
        }
      });
    });

    super.initState();
  }

  Future<Driver?> loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    setState(() {
      _currentDriver = driver;
    });
    return driver;
  }

  Future<void> welcomeDialog() {
    return AppDialogs().showDialogJustMsg(context, "Welcome Driver",
        "Make your checkin and start to check bags.");
  }

  Future<void> clickWrongWelcomeMessageDialog() {
    return AppDialogs().showDialogJustMsg(context, "Attention",
        "You need to check bags first to send welcome message.");
  }

  Future<void> finishCheckBagDialog() {
    return AppDialogs().showDialogJustMsg(context, "Finish Bags Check",
        "Now, send welcome message to start delivering.");
  }

  Future<void> sendingWelcomeMessageDialog() {
    return AppDialogs().showConfirmDialog(
        context,
        () => {screenViewModel.goToInTransitScreen(_currentDriver!)},
        "Confirm",
        "Welcome messages will be sent to customers and you can start delivering!");
  }

  Future<void> inTransitDialog() {
    return AppDialogs().showDialogJustMsg(context, "In Transit",
        "You checked your bags and you can delivery now.");
  }

  Future<void> finishRouteDialog() {
    return AppDialogs()
        .showDialogJustMsg(context, "Route Done", "You finish your route.");
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

  Widget expandedStatusBar(String text, int fixedNumber, int varNumber) {
    return Expanded(
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: getStatusColor(fixedNumber, varNumber))));
  }

  Widget toCheckIn(bool madeCheckIn) {
    if (_currentRoute != null && _currentRoute!.status!.index > 0) {
      if (_currentRoute!.status == RouteStatus.INITIATED) {
        screenViewModel.goToBagsChecking();
      }

      DateTime time = DateTime.fromMillisecondsSinceEpoch(
          _currentRoute!.startTime!.toSeconds() * 1000);
      String timeFormatted = DateFormat('kk:mm').format(time);
      return Container(
          padding: const EdgeInsets.only(left: 18, top: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Initiated at: $timeFormatted",
            style: TextStyle(fontSize: 14, color: App_Colors.grey_dark.value),
          ));
    } else {
      return GestureDetector(
          onTap: () {
            Amplify.DataStore.save(_currentRoute!.copyWith(
                status: RouteStatus.INITIATED,
                startTime: TemporalTimestamp(DateTime.now())));
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

  Widget getWelcomeMessage() {
    if (screenViewModel.screenState.value == RoutePageState.firstOpen ||
        screenViewModel.screenState.value == RoutePageState.routePlan ||
        screenViewModel.screenState.value == RoutePageState.bagsChecking ||
        screenViewModel.screenState.value == RoutePageState.bagsChecked) {
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
          onTap: clickWrongWelcomeMessageDialog);
    } else if (screenViewModel.screenState.value ==
        RoutePageState.welcomeMessage) {
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
          onTap: sendingWelcomeMessageDialog);
    } else {
      return Container(
        padding: EdgeInsets.only(right: 25, top: 5),
        child: Text(
          "message sent",
          style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value),
        ),
        alignment: Alignment.centerLeft,
      );
    }
  }

  void goToViewOnMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondRoute(orders: screenViewModel.orderList)),
    );
  }

  Widget routeDone() {
    return Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 160, bottom: 160),
        child: ElevatedButton(
          onPressed: () {
            screenViewModel.clearClientList();
            Modular.to.navigate('./');
          },
          style:
              ElevatedButton.styleFrom(primary: App_Colors.primary_color.value),
          child: Text("Finish route",
              style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      switch (screenViewModel.screenState.value) {
        case RoutePageState.firstOpen:
          Future.delayed(Duration.zero, welcomeDialog);
          screenViewModel.goToRoutePlan();
          break;
        case RoutePageState.routePlan:
        case RoutePageState.bagsChecking:
          break;
        case RoutePageState.bagsChecked:
          Future.delayed(Duration.zero, finishCheckBagDialog);
          screenViewModel.goToWelcomeMessageState();
          break;
        case RoutePageState.welcomeMessage:
        case RoutePageState.inTransit:
        case RoutePageState.routeDone:
          break;
      }
      return Scaffold(
        backgroundColor: App_Colors.white_background.value,
        body: Center(
          child: SingleChildScrollView(child: Observer(builder: (_) {
            return Column(
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
                              builder: (_) => toCheckIn(
                                  screenViewModel.screenState.value !=
                                      RoutePageState.routePlan)),
                          getWelcomeMessage()
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
                              style: TextStyle(
                                  fontFamily: "Poppins", fontSize: 16))
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
                          expandedStatusBar("Route plan", 0,
                              screenViewModel.statusRouteBar.value),
                          expandedStatusBar("Bags checking", 1,
                              screenViewModel.statusRouteBar.value),
                          expandedStatusBar("In transit", 2,
                              screenViewModel.statusRouteBar.value),
                          expandedStatusBar("Route done", 3,
                              screenViewModel.statusRouteBar.value)
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
                                          color:
                                              App_Colors.primary_color.value),
                                    )
                                  ])),
                              onTap: goToViewOnMap)
                        ]),
                    Container(
                        height: MediaQuery.of(context).size.height / 2.1,
                        child: Observer(builder: (_) {
                          if (screenViewModel.screenState.value ==
                              RoutePageState.routeDone) {
                            return routeDone();
                          }
                          if (_currentDriver != null) {
                            return OrdersListView(_currentDriver!);
                          }
                          return Center();
                        }))
                  ]),
                ]);
          })),
        ),
      );
    });
  }
}
