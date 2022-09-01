// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/components/AppLoading.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import 'package:mps_driver_app/store/route/RouteStore.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../../components/AppDialogs.dart';
import '../services/TwilioService.dart';
import 'components/OrderItem.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as stepper;
import 'MapsPage.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StateRoutePage();
}

class StateRoutePage extends State<RoutePage> {
  int dotCount = 4;
  final _routeStore = Modular.get<RouteStore>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_routeStore.currentDriver == null) {
        await _routeStore.retrieveDriverInformation();
      }

      if (_routeStore.orders == null) {
        await _routeStore.fetchOrders();
      }

      if (_routeStore.routeOrders == null) {
        await _routeStore.retrieveRouteOrders();
      }
    });

    final overlayLoading = OverlayEntry(builder: (_){
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: AppLoading(),
      );
    });

    reaction((_) => _routeStore.loading, (isLoading) {
      if(isLoading == true){
        Overlay.of(context)?.insert(overlayLoading);
      } else {
        overlayLoading.remove();
      }
    });

    super.initState();
  }

  Future<void> welcomeDialog() {
    return AppDialogs().showDialogJustMsg(context, "Welcome Driver",
        "Make your checkin and start to check bags.");
  }

  Future<void> clickWrongWelcomeMessageDialogBefore() {
    return AppDialogs().showDialogJustMsg(context, "Attention",
        "You need to check bags first to send welcome message.");
  }

  Future<void> clickWrongWelcomeMessageDialogAfter() {
    return AppDialogs().showDialogJustMsg(context, "Attention",
        "You already send the welcome message.");
  }

  Future<void> finishCheckBagDialog() {
    return AppDialogs().showDialogJustMsg(context, "Finish Bags Check",
        "Now, send welcome message to start delivering.");
  }

  Future<void> sendWelcomeMessages() async {
    TwilioSmsService smsService = TwilioSmsService(_routeStore.currentDriver!);
    int index = 0;
    for (var order in _routeStore.routeOrders!) {
      // smsService.sendSms(order!.customerName!, order.phone!, order.eta);
      await setOrderStatus(index, OrderStatus.IN_TRANSIT);
      index += 1;
    }
  }

  Future<void> sendingWelcomeMessageDialog() {
    return AppDialogs().showConfirmDialog(
        context,
        () => {setRouteStatus(RouteStatus.IN_TRANSIT), sendWelcomeMessages()},
        "Confirm",
        "Welcome messages will be sent to customers and you can start delivering!");
  }

  Future<void> inTransitDialog() {
    return AppDialogs().showDialogJustMsg(context, "In Transit",
        "You checked your bags and you can delivery now.");
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

  Widget expandedStatusBar(String text, int fixedNumber) {
    int varNumber = getActiveStepperByRouteStatus();
    return Expanded(
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: getStatusColor(fixedNumber, varNumber))));
  }

  void setRouteStatus(RouteStatus newStatus) {
    MRoute newRoute = _routeStore.assignedRoute!.copyWith(status: newStatus);
    _routeStore.updateAssignedRoute(newRoute);
  }

  RouteStatus? getRouteStatus() {
    return _routeStore.assignedRoute!.status;
  }

  Widget toCheckIn() {
    if (_routeStore.assignedRoute != null &&
        _routeStore.assignedRoute!.status!.index > 1) {
      if (_routeStore.assignedRoute!.status == RouteStatus.INITIATED) {
        setRouteStatus(RouteStatus.CHECKING_BAGS);
      }

      DateTime time = DateTime.fromMillisecondsSinceEpoch(1000);
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
            _routeStore.assignedRoute =
                _routeStore.assignedRoute!.copyWith(startTime: 000);
            setRouteStatus(RouteStatus.INITIATED);
          },
          child: Container(
              padding: const EdgeInsets.only(left: 18, top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                "Check-in",
                style: TextStyle(
                    fontSize: 14, color: App_Colors.primary_color.value),
              )));
    }
  }

  Widget getWelcomeMessage() {
    if (_routeStore.assignedRoute != null) {
      if (_routeStore.assignedRoute!.status == RouteStatus.PLANNED ||
          _routeStore.assignedRoute!.status == RouteStatus.ASSIGNED ||
          _routeStore.assignedRoute!.status == RouteStatus.INITIATED ||
          _routeStore.assignedRoute!.status == RouteStatus.CHECKING_BAGS) {
        return Container(
          alignment: Alignment.centerLeft,
          child: OutlinedButton(
              onPressed: () {
                clickWrongWelcomeMessageDialogBefore();
              },
              child: Icon(Icons.send, color: App_Colors.grey_text.value)),
        );
      } else if (_routeStore.assignedRoute!.status ==
          RouteStatus.SENDING_WELCOME_MESSAGES) {
        return Container(
          alignment: Alignment.centerLeft,
          child: OutlinedButton(
              onPressed: () {
                sendingWelcomeMessageDialog();
              },
              child: Icon(Icons.send, color: App_Colors.primary_color.value)),
        );
      } else {
        return OutlinedButton(
            onPressed: () {
              clickWrongWelcomeMessageDialogAfter();
            },
            child: Icon(Icons.send, color: App_Colors.grey_text.value));
      }
    } else {
      return const Center();
    }
  }

  void goToViewOnMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondRoute(
              orders: /*_routeViewModel.lastActivedRoute!.orders!*/ [])),
    );
  }

  void endRoute() {
    _routeStore.assignedRoute =
        _routeStore.assignedRoute!.copyWith(endTime: 000);
    setRouteStatus(RouteStatus.DONE);
    _routeStore.updateDriver(_routeStore.currentDriver!.copyWith(
      assignStatus: AssignStatus.UNASSIGNED
    ));
    // _routeStore.setIsRouteActived(false);
    // _routeStore.addToRoutesHistory(_routeStore.assignedRoute!);
    Modular.to.pushNamed('/main/history/details',
        arguments: _routeStore.assignedRoute);
  }

  Widget routeDone() {
    return Center(
        child: ElevatedButton(
      onPressed: () async => {endRoute()},
      style: ElevatedButton.styleFrom(primary: App_Colors.primary_color.value),
      child: const Text("Finish route",
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
    ));
  }

  int getActiveStepperByRouteStatus() {
    if (_routeStore.assignedRoute != null) {
      switch (_routeStore.assignedRoute!.status) {
        case RouteStatus.PLANNED:
          return 0;
        case RouteStatus.INITIATED:
        case RouteStatus.CHECKING_BAGS:
        case RouteStatus.SENDING_WELCOME_MESSAGES:
          return 1;
        case RouteStatus.IN_TRANSIT:
          return 2;
        case RouteStatus.DONE:
        case RouteStatus.ON_HOLD:
        case RouteStatus.CANCELED:
          return 3;
        default:
          return 0;
      }
    }
    return 0;
  }

  void verifyAllOrderStatusChanged(OrderStatus status,
      [OrderStatus? additionalStatus]) {
    bool allChanged = true;
    for (MOrder? order in _routeStore.routeOrders!) {
      allChanged =
          (order!.status == status || order.status == additionalStatus);
      if (!allChanged) break;
    }
    if (allChanged) {
      if (status == OrderStatus.CHECKED) {
        Future.delayed(Duration.zero, finishCheckBagDialog);
        setRouteStatus(RouteStatus.SENDING_WELCOME_MESSAGES);
      } else if (status == OrderStatus.DELIVERED ||
          status == additionalStatus) {
        setRouteStatus(RouteStatus.DONE);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _routeStore.assignedRoute != null
        ? Observer(
            builder: (_) => Scaffold(
                  backgroundColor: App_Colors.white_background.value,
                  body: Center(
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 18),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      _routeStore.currentDriver != null
                                          ? Text(
                                              "${_routeStore.currentDriver?.name}  ",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : const Text(""),
                                      DotIndicator(
                                        color: App_Colors.primary_color.value,
                                        size: 8,
                                      )
                                    ],
                                  )),
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [toCheckIn(), Row(children: [
                                  OutlinedButton(
                                      onPressed: () async {
                                        _routeStore.setLoading(true);
                                        await _routeStore.fetchAssignedRoute();
                                        _routeStore.setLoading(false);
                                      },
                                      child: const Icon(Icons.refresh)),
                                  SizedBox(width: 10),
                                  getWelcomeMessage(),
                                  SizedBox(width: 20)
                                ],)],
                              ),
                              const SizedBox(height: 15),
                              const Divider(thickness: 1),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(children: const [
                                  Text("Route Status",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Poppins", fontSize: 16))
                                ]),
                              ),
                              const SizedBox(height: 15),
                              stepper.IconStepper(
                                scrollingDisabled: true,
                                enableNextPreviousButtons: false,
                                icons: const [
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
                                activeStep: getActiveStepperByRouteStatus(),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  expandedStatusBar("Route plan", 0),
                                  expandedStatusBar("Bags checking", 1),
                                  expandedStatusBar("In transit", 2),
                                  expandedStatusBar(
                                    "Route done",
                                    3,
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider(thickness: 1),
                            ],
                          ),
                          Column(children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 18),
                                    child: const Text(
                                      "Deliveries",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: goToViewOnMap,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: Column(children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: App_Colors
                                                  .primary_color.value,
                                            ),
                                            Text(
                                              "Route map",
                                              style: TextStyle(
                                                  color: App_Colors
                                                      .primary_color.value),
                                            )
                                          ])))
                                ]),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.1,
                                child: (() {
                                  if (_routeStore.assignedRoute!.status ==
                                      RouteStatus.DONE) {
                                    return routeDone();
                                  }
                                  if (_routeStore.currentDriver != null &&
                                      _routeStore.assignedRoute!.status !=
                                          RouteStatus.DONE &&
                                      _routeStore.routeOrders != null) {
                                    return Observer(
                                        builder: (_) => ListView(
                                            padding: const EdgeInsets.all(8),
                                            children: _routeStore.routeOrders!
                                                .map((order) => Observer(
                                                    builder: (_) => OrderItem(
                                                        order,
                                                        _routeStore.routeOrders!
                                                            .indexOf(order),
                                                        _routeStore
                                                            .currentDriver!,
                                                        this)))
                                                .toList()));
                                  } else {
                                    return const Center();
                                  }
                                }()))
                          ]),
                        ])),
                  ),
                ))
        : const Center();
  }

  Future<void> setOrderStatus(int orderIndex, OrderStatus newStatus) async {
    MOrder? order =
        _routeStore.routeOrders![orderIndex]!.copyWith(status: newStatus);
    await _routeStore.updateAssignedRouteOrder(orderIndex, order);

    verifyAllOrderStatusChanged(newStatus);
  }

  Future<void> registerDeliveryURL(int index, String key) async {
    MOrder? order = _routeStore.routeOrders![index]!.copyWith(deliveryKey: key);
    await _routeStore.updateAssignedRouteOrder(index, order);
  }
}
