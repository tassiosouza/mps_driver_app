// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../../Services/DriverService.dart';
import '../../../components/AppDialogs.dart';
import '../services/TwilioService.dart';
import 'RouteViewModel.dart';
import 'components/OrdersListView.dart';
import 'package:status_change/status_change.dart';
import 'package:im_stepper/stepper.dart' as stepper;
import 'MapsPage.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
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
  final _routeViewModel = Modular.get<RouteViewModel>();

  StreamSubscription<GraphQLResponse<MpsRoute>>? subscription;

  GraphQLClient initGqlClient(String url) {
    final link = HttpLink(
      url,
      defaultHeaders: {
        'x-api-key': 'da2-qhpgfyyngje3tmlbbf5na574sq',
        'Content-Type': 'application/json',
      },
    );

    final client = GraphQLClient(link: link, cache: GraphQLCache());

    return client;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var graphQLClient = initGqlClient(
          'https://27e6dnolwrdabfwawi2u5pfe4y.appsync-api.us-west-1.amazonaws.com/graphql');

//       var result = await graphQLClient.query(QueryOptions(
//         document: gql('''query MyQuery {
//   listMpsRoutes(filter: {mpsRouteDriverId: {eq: ${driver!.id}}, status: {ne: DONE}}) {
//     items {
//       id
//       mpsRouteDriverId
//       _version
//       name
//       duration
//       endTime
//       distance
//       startTime
//       status
//       orders {
//         items {
//           customer {
//             address
//             coordinates {
//               id
//               latitude
//               longitude
//             }
//             id
//             name
//             phone
//           }
//           deliveryInstruction
//           eta
//           id
//           mealsInstruction
//           number
//           status
//         }
//       }
//     }
//   }
// }

//               '''),
//       ));
//       log(result.toString());

//       MpsRoute fetchedRoute = mountFechedRoute(result);

      //API Subscribe
      final subscriptionRequest =
          ModelSubscriptions.onUpdate(MpsRoute.classType);
      final Stream<GraphQLResponse<MpsRoute>> operation = Amplify.API.subscribe(
        subscriptionRequest,
        onEstablished: () => print('Subscription established'),
      );
      String id = '';
      subscription = operation.listen(
        (event) async {
          print('Subscription event data received: ${event.data}');
        },
        onError: (Object e) => print('Error in subscription stream: $e'),
      );
    });

    //   _routesSubscription = Amplify.DataStore.observeQuery(MpsRoute.classType,
    //           where: MpsRoute.MPSROUTEDRIVERID.eq(driver?.getId()))
    //       .listen((QuerySnapshot<MpsRoute> snapshot) {
    //     List<MpsRoute> routes = snapshot.items;
    //     MpsRoute currentRouteUpdate;
    //     if (_currentRoute != null) {
    //       currentRouteUpdate = routes
    //           .where((route) =>
    //               route.id == _currentRoute?.id &&
    //               route.status != RouteStatus.DONE &&
    //               route.status != RouteStatus.ABORTED)
    //           .toList()[0];

    //       setState(() {
    //         _currentRoute = currentRouteUpdate;
    //       });

    //       log("the current route has been update");
    //     } else {
    //       for (MpsRoute route in routes) {
    //         if (route.status != RouteStatus.DONE &&
    //             route.status != RouteStatus.ABORTED) {
    //           setState(() {
    //             _currentRoute = route;
    //           });
    //           configureOrdersSubscription(route);
    //         }
    //       }
    //     }
    //   });
    // });

    // if (_currentRoute != null) {
    //   if (_currentRoute!.status == RouteStatus.PLANNED) {
    //     Future.delayed(Duration.zero, welcomeDialog);
    //   }
    // }

    super.initState();
  }

  // void configureOrdersSubscription(MpsRoute route) {
  //   _ordersSubscription = Amplify.DataStore.observeQuery(MpOrder.classType,
  //           where: MpOrder.ROUTEID.eq(route.getId()))
  //       .listen((QuerySnapshot<MpOrder> snapshot) async {
  //     List<MpOrder> updatedOrders = snapshot.items;
  //     _currentOrders ??= updatedOrders;
  //     for (int i = 0; i < updatedOrders.length; i++) {
  //       if (updatedOrders[i].mpOrderCustomerId != null) {
  //         List<Customer> customers = await Amplify.DataStore.query(
  //             Customer.classType,
  //             where: Customer.ID.eq(updatedOrders[i].mpOrderCustomerId));
  //         Customer orderCustomer = customers[0];
  //         //Add amplify coordinates to customer
  //         List<Coordinates> coordinates = await Amplify.DataStore.query(
  //             Coordinates.classType,
  //             where: Coordinates.ID.eq(customers[0].customerCoordinatesId));
  //         orderCustomer = orderCustomer.copyWith(coordinates: coordinates[0]);

  //         //Add amplify customer to order
  //         _currentOrders![i] =
  //             updatedOrders[i].copyWith(customer: orderCustomer);
  //       } else {
  //         _currentOrders![i] =
  //             _currentOrders![i].copyWith(status: updatedOrders[i].status);
  //       }
  //     }

  //     setStateIfMounted(() {
  //       () {
  //         _currentOrders = _currentOrders;
  //       };
  //     });
  //   });
  // }

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
    TwilioSmsService smsService =
        TwilioSmsService(_routeViewModel.currentDriver!);
    for (var order in _routeViewModel.lastActivedRoute!.orders!) {
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
    MpsRoute newRoute =
        _routeViewModel.lastActivedRoute!.copyWith(status: newStatus);
    _routeViewModel.setlastActivedRoute(newRoute);
    Amplify.DataStore.save(newRoute);
  }

  RouteStatus? getRouteStatus() {
    return _routeViewModel.lastActivedRoute!.status;
  }

  Widget toCheckIn() {
    if (_routeViewModel.lastActivedRoute != null &&
        _routeViewModel.lastActivedRoute!.status!.index > 0) {
      if (_routeViewModel.lastActivedRoute!.status == RouteStatus.INITIATED) {
        setRouteStatus(RouteStatus.CHECKING_BAGS);
      }

      DateTime time = DateTime.fromMillisecondsSinceEpoch(
          _routeViewModel.lastActivedRoute!.startTime!.toSeconds() * 1000);
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
            _routeViewModel.lastActivedRoute = _routeViewModel.lastActivedRoute!
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
    if (_routeViewModel.lastActivedRoute != null) {
      if (_routeViewModel.lastActivedRoute!.status == RouteStatus.PLANNED ||
          _routeViewModel.lastActivedRoute!.status == RouteStatus.INITIATED ||
          _routeViewModel.lastActivedRoute!.status ==
              RouteStatus.CHECKING_BAGS) {
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
      } else if (_routeViewModel.lastActivedRoute!.status ==
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
          builder: (context) =>
              SecondRoute(orders: _routeViewModel.lastActivedRoute!.orders!)),
    );
  }

  void endRoute() {
    _routeViewModel.lastActivedRoute = _routeViewModel.lastActivedRoute!
        .copyWith(endTime: TemporalTimestamp(DateTime.now()));
    setRouteStatus(RouteStatus.DONE);
    _routeViewModel.setIsRouteActived(false);
    _routeViewModel.addToRoutesHistory(_routeViewModel.lastActivedRoute!);
    Modular.to
        .pushNamed('./details', arguments: _routeViewModel.lastActivedRoute);
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
    if (_routeViewModel.lastActivedRoute != null) {
      switch (_routeViewModel.lastActivedRoute!.status) {
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

  void verifyAllOrderStatusChanged(MpsOrderStatus status,
      [MpsOrderStatus? additionalStatus]) {
    bool allChanged = true;
    for (MpOrder order in _routeViewModel.lastActivedRoute!.orders!) {
      allChanged = (order.status == status || order.status == additionalStatus);
      if (!allChanged) break;
    }
    if (allChanged) {
      if (status == MpsOrderStatus.CHECKED) {
        Future.delayed(Duration.zero, finishCheckBagDialog);
        setRouteStatus(RouteStatus.SENDING_WELCOME_MESSAGES);
      } else if (status == MpsOrderStatus.DELIVERED ||
          status == additionalStatus) {
        setRouteStatus(RouteStatus.DONE);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _routeViewModel.lastActivedRoute != null
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
                                      _routeViewModel.currentDriver != null
                                          ? Text(
                                              "${_routeViewModel.currentDriver?.name}  ",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  if (_routeViewModel
                                          .lastActivedRoute!.status ==
                                      RouteStatus.DONE) {
                                    return routeDone();
                                  }
                                  if (_routeViewModel.currentDriver != null &&
                                      _routeViewModel
                                              .lastActivedRoute!.status !=
                                          RouteStatus.DONE) {
                                    return OrdersListView(
                                        _routeViewModel.currentDriver!,
                                        _routeViewModel
                                            .lastActivedRoute!.orders,
                                        this);
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

  Future<void> setOrderStatus(int orderIndex, MpsOrderStatus newStatus) async {
    _routeViewModel.lastActivedRoute!.orders![orderIndex] = _routeViewModel
        .lastActivedRoute!.orders![orderIndex]
        .copyWith(status: newStatus);
    try {
      _routeViewModel.setlastActivedRoute(_routeViewModel.lastActivedRoute!);
      await Amplify.DataStore.save(
          _routeViewModel.lastActivedRoute!.orders![orderIndex]);
    } catch (e) {
      print('An error occurred while saving Order Status: $e');
    }
  }
}
