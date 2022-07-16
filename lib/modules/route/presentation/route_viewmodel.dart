import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:mps_driver_app/models/OrderStatus.dart';
import 'package:mps_driver_app/models/RouteStatus.dart';
import 'package:mps_driver_app/modules/route/presentation/RouteLoading.dart';
import 'package:mps_driver_app/modules/route/services/PickRouteFile.dart';
import 'package:mps_driver_app/modules/route/services/TwilioService.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import '../../../models/Client.dart';
import 'package:mobx/mobx.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../models/Customer.dart';
import '../../../models/Driver.dart';
import '../../../models/MpsOrder.dart';
import '../../../models/Route.dart' as RouteModel;
part 'route_viewmodel.g.dart';

class RouteViewModel = _RouteViewModel with _$RouteViewModel;

abstract class _RouteViewModel with Store {
  PickRouteFile pickRouteFile = PickRouteFile();

  @observable
  var screenState = Observable(RoutePageState.firstOpen);

  @action
  void backToFirstOpenState() {
    screenState.value = RoutePageState.firstOpen;
    statusRouteBar.value = 0;
  }

  @action
  void goToRoutePlan() {
    screenState.value = RoutePageState.routePlan;
    statusRouteBar.value = 0;
  }

  @action
  void goToBagsChecking() {
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 1;
  }

  @action
  void goToWelcomeMessageState() {
    screenState.value = RoutePageState.welcomeMessage;
    statusRouteBar.value = 1;
  }

  @action
  void goToInTransitScreen(
      Driver currentDriver, List<MpsOrder> orders, bool alreadySent) {
    TwilioSmsService smsService = TwilioSmsService(currentDriver);
    if (!alreadySent) {
      for (var order in orders) {
        smsService.sendSms(
            order.customer!.name, order.customer!.phone, order.eta);
      }
    }
    screenState.value = RoutePageState.inTransit;
    statusRouteBar.value = 2;
  }

  @action
  void goToRouteDoneScreen() {
    screenState.value = RoutePageState.routeDone;
    statusRouteBar.value = 3;
  }

  @action
  void clearClientList() {
    clientList.clear();
  }

  @observable
  var checkingTime = Observable('');

  @action
  void setCheckingTime(String time) {
    checkingTime.value = time;
  }

  @observable
  var isInRoute = Observable(false);

  @action
  void setIsInRoute(bool inRoute) {
    isInRoute.value = inRoute;
  }

  @observable
  var clientList = ObservableList<Client>();

  @observable
  var orderList = ObservableList<MpsOrder>();

  @action
  void setOrderList(List<MpsOrder> orders) {
    orderList.clear();
    orderList.addAll(orders);
  }

  @observable
  var currentRoute = Observable<RouteModel.Route>(RouteModel.Route(name: ""));

  @action
  void setCurrentRoute(RouteModel.Route route) {
    currentRoute.value = route;
  }

  @observable
  var statusRouteBar = Observable(0);

  @action
  Future<void> getClientList() async {
    //clientList.addAll(await pickRouteFile.pickFiles());
    clientList.addAll([]);
  }

  @action
  Future<void> getOrderList(Driver currentDriver) async {
    RouteModel.Route route = RouteModel.Route(
        name: "R100 - ${currentDriver.name}",
        routeDriverId: currentDriver.id,
        orders: orderList,
        status: RouteStatus.PLANNED,
        driver: currentDriver);

    orderList.addAll(await pickRouteFile.readOrdersFromFile(route.id));

    route = route.copyWith(orders: orderList);

    uploadRouteToAmplify(route);
  }

  Future<void> uploadRouteToAmplify(RouteModel.Route route) async {
    for (MpsOrder order in route.orders!) {
      await Amplify.DataStore.save(order.customer!.coordinates!);
      await Amplify.DataStore.save(order.customer!);
      await Amplify.DataStore.save(order);
    }
    await Amplify.DataStore.save(route);
  }

  @action
  void goToBagsScreen() {
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 1;
  }

  @action
  void verifyBags(Driver currentDriver) {
    bool checkBagsFinish = true;
    for (var order in orderList) {
      if (order.status != OrderStatus.CHECKED) {
        checkBagsFinish = false;
      }
    }
    if (checkBagsFinish == true) {
      screenState.value = RoutePageState.bagsChecked;
    }
  }

  @action
  void verifyPhotosSent() {
    bool routeFinish = true;
    for (var order in orderList) {
      if (order.status != OrderStatus.DELIVERED) {
        routeFinish = false;
      }
    }
    if (routeFinish == true) {
      goToRouteDoneScreen();
      Amplify.DataStore.save(
          currentRoute.value.copyWith(status: RouteStatus.DONE));
    }
  }
}
