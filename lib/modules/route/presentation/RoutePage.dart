// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../../Services/DriverService.dart';
import '../../../components/AppDialogs.dart';
import '../services/TwilioService.dart';
import 'components/OrdersListView.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as stepper;
import '../../../models/Route.dart' as route_model;
import 'MapsPage.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateRoutePage();
}

class StateRoutePage extends State<RoutePage> {
  int dotCount = 4;
  Driver? _currentDriver;
  route_model.Route? _currentRoute;
  late StreamSubscription<QuerySnapshot<route_model.Route>> _routesSubscription;
  late StreamSubscription<QuerySnapshot<MpsOrder>> _ordersSubscription;
  List<MpsOrder>? _currentOrders;

  @override
  void initState() {
    Driver? driver;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      driver = await loadDriverInformation();

      _routesSubscription = Amplify.DataStore.observeQuery(
              route_model.Route.classType,
              where: route_model.Route.ROUTEDRIVERID.eq(driver?.getId()))
          .listen((QuerySnapshot<route_model.Route> snapshot) {
        List<route_model.Route> routes = snapshot.items;
        route_model.Route currentRouteUpdate;
        if (_currentRoute != null) {
          currentRouteUpdate = routes
              .where((route) =>
                  route.id == _currentRoute?.id &&
                  route.status != RouteStatus.DONE &&
                  route.status != RouteStatus.ABORTED)
              .toList()[0];

          setState(() {
            _currentRoute = currentRouteUpdate;
          });
          log("the current route has been update");
        } else {
          for (route_model.Route route in routes) {
            if (route.status != RouteStatus.DONE &&
                route.status != RouteStatus.ABORTED) {
              setState(() {
                _currentRoute = route;
              });
              configureOrdersSubscription(route);
            }
          }
        }
      });
    });

    if (_currentRoute != null) {
      if (_currentRoute!.status == RouteStatus.PLANNED) {
        Future.delayed(Duration.zero, welcomeDialog);
      }
    }

    super.initState();
  }

  void configureOrdersSubscription(route_model.Route route) {
    _ordersSubscription = Amplify.DataStore.observeQuery(MpsOrder.classType,
            where: MpsOrder.ROUTEID.eq(route.getId()))
        .listen((QuerySnapshot<MpsOrder> snapshot) async {
      _currentOrders = snapshot.items;
      for (int i = 0; i < _currentOrders!.length; i++) {
        List<Customer> customers = await Amplify.DataStore.query(
            Customer.classType,
            where: Customer.ID.eq(_currentOrders![i].mpsOrderCustomerId));
        Customer orderCustomer = customers[0];
        //Add amplify coordinates to customer
        List<Coordinates> coordinates = await Amplify.DataStore.query(
            Coordinates.classType,
            where: Coordinates.ID.eq(customers[0]!.customerCoordinatesId));
        orderCustomer = orderCustomer.copyWith(coordinates: coordinates[0]);

        //Add amplify customer to order
        _currentOrders![i] =
            _currentOrders![i].copyWith(customer: orderCustomer);
      }
      setStateIfMounted(() {
        () {
          _currentOrders = _currentOrders;
        };
      });
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
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

  void sendWelcomeMessages() {
    TwilioSmsService smsService = TwilioSmsService(_currentDriver!);
    for (var order in _currentOrders!) {
      smsService.sendSms(
          order.customer!.name, order.customer!.phone, order.eta);
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
    route_model.Route newRoute = _currentRoute!.copyWith(status: newStatus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentRoute = newRoute;
      });
    });
    Amplify.DataStore.save(newRoute);
  }

  RouteStatus? getRouteStatus() {
    return _currentRoute!.status;
  }

  Widget toCheckIn() {
    if (_currentRoute != null && _currentRoute!.status!.index > 0) {
      if (_currentRoute!.status == RouteStatus.INITIATED) {
        setRouteStatus(RouteStatus.CHECKING_BAGS);
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
            _currentRoute = _currentRoute!
                .copyWith(startTime: TemporalTimestamp(DateTime.now()));
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
    if (_currentRoute != null) {
      if (_currentRoute!.status == RouteStatus.PLANNED ||
          _currentRoute!.status == RouteStatus.INITIATED ||
          _currentRoute!.status == RouteStatus.CHECKING_BAGS) {
        return GestureDetector(
            onTap: clickWrongWelcomeMessageDialog,
            child: Container(
              padding: const EdgeInsets.only(right: 25, top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome messages",
                style: TextStyle(
                    fontSize: 14, color: App_Colors.primary_color.value),
              ),
            ));
      } else if (_currentRoute!.status ==
          RouteStatus.SENDING_WELCOME_MESSAGES) {
        return GestureDetector(
            onTap: sendingWelcomeMessageDialog,
            child: Container(
              padding: const EdgeInsets.only(right: 25, top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome messages",
                style: TextStyle(
                    fontSize: 14, color: App_Colors.primary_color.value),
              ),
            ));
      } else {
        return Container(
          padding: const EdgeInsets.only(right: 25, top: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Messages sent",
            style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value),
          ),
        );
      }
    } else {
      return const Center();
    }
  }

  void goToViewOnMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondRoute(orders: _currentOrders!)),
    );
  }

  Widget routeDone() {
    return Center(
        child: ElevatedButton(
      onPressed: () => {
        setState(() {
          _currentRoute = null;
        }),
        Modular.to.navigate('./'),
      },
      style: ElevatedButton.styleFrom(primary: App_Colors.primary_color.value),
      child: const Text("Finish route",
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
    ));
  }

  int getActiveStepperByRouteStatus() {
    if (_currentRoute != null) {
      switch (_currentRoute!.status) {
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
        case RouteStatus.ABORTED:
          return 3;
        default:
          return 0;
      }
    }
    return 0;
  }

  void verifyAllOrderStatusChanged(OrderStatus status) {
    bool allChanged = true;
    for (MpsOrder order in _currentOrders!) {
      allChanged = (order.status == status);
    }
    if (allChanged) {
      if (status == OrderStatus.CHECKED) {
        Future.delayed(Duration.zero, finishCheckBagDialog);
        setRouteStatus(RouteStatus.SENDING_WELCOME_MESSAGES);
      } else if (status == OrderStatus.DELIVERED) {
        setRouteStatus(RouteStatus.DONE);
      }
    }
  }

  bool isFullySynced() {
    bool fullySynced = true;
    if (_currentRoute == null) {
      fullySynced = false;
    } else if (_currentOrders == null) {
      fullySynced = false;
    } else {
      for (MpsOrder order in _currentOrders!) {
        if (order.customer == null) {
          fullySynced = false;
        }
      }
    }

    return fullySynced;
  }

  @override
  Widget build(BuildContext context) {
    return isFullySynced()
        ? Scaffold(
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
                                _currentDriver != null
                                    ? Text(
                                        "${_currentDriver?.name}  ",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [toCheckIn(), getWelcomeMessage()],
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

                          // // This ensures step-tapping updates the activeStep.
                          // onStepReached: (index) {
                          //   setState(() {
                          //     screenViewModel.statusRouteBar.value = index;
                          //   });
                          // },
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 18),
                              child: const Text(
                                "Deliveries",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                                onTap: goToViewOnMap,
                                child: Container(
                                    padding: const EdgeInsets.only(right: 25),
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
                                    ])))
                          ]),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 2.1,
                          child: (() {
                            if (_currentRoute!.status == RouteStatus.DONE) {
                              return routeDone();
                            }
                            if (_currentDriver != null &&
                                _currentRoute!.status != RouteStatus.DONE) {
                              return OrdersListView(
                                  _currentDriver!, _currentOrders!, this);
                            } else {
                              return const Center();
                            }
                          }()))
                    ]),
                  ])),
            ),
          )
        : const Center();
  }

  Future<void> setOrderStatus(int orderIndex, OrderStatus newStatus) async {
    _currentOrders![orderIndex] =
        _currentOrders![orderIndex].copyWith(status: newStatus);
    try {
      setState(() {
        _currentOrders = _currentOrders;
      });
      await Amplify.DataStore.save(_currentOrders![orderIndex]);
    } catch (e) {
      print('An error occurred while saving Order Status: $e');
    }
  }
}
