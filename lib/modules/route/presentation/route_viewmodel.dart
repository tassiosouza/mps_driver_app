import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/OrderStatus.dart';
import 'package:mps_driver_app/modules/route/presentation/RouteLoading.dart';
import 'package:mps_driver_app/modules/route/services/PickRouteFile.dart';
import 'package:mps_driver_app/modules/route/services/TwilioService.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import '../../../models/Client.dart';
import 'package:mobx/mobx.dart';
import '../../../models/Customer.dart';
import '../../../models/Driver.dart';
import '../../../models/Order.dart';
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
  void goToInTransitScreen(Driver currentDriver) {
    TwilioSmsService smsService = TwilioSmsService(currentDriver);
    for (var client in clientList) {
      smsService.sendSms(client.name, client.phone, client.eta);
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
  var clientList = ObservableList<Client>();

  @observable
  var orderList = ObservableList<Order>();

  @observable
  var statusRouteBar = Observable(0);

  @action
  Future<void> getClientList() async {
    clientList.addAll(await pickRouteFile.pickFiles());
  }

  @action
  void getOrderList() {
    Customer customer = Customer(
        address: "1445 Washington St, #508, San Diego, CA 92103",
        name: "Erik Clarke",
        phone: "6197634382");
    Customer customer1 = Customer(
        address: "2411 El Cajon Blvd, Apt 302, San Diego, CA 92104",
        name: "Jose Fernandes",
        phone: "6197634382");
    Customer customer2 = Customer(
        address: "3740 Park Blvd, APT 118, San Diego, CA 92103",
        name: "Tassio Souza",
        phone: "6197634382");
    orderList.add(Order(
        number: "#00000",
        routeID: "routeid",
        customer: customer,
        mealsInstruction: "fsdfs",
        status: OrderStatus.RECEIVED));
    orderList.add(Order(
        number: "#11111",
        routeID: "routeid",
        customer: customer1,
        mealsInstruction: "fsdfs",
        status: OrderStatus.RECEIVED));
    orderList.add(Order(
        number: "#22222",
        routeID: "routeid",
        customer: customer2,
        mealsInstruction: "fsdfs",
        status: OrderStatus.RECEIVED));
  }

  @action
  void goToBagsScreen() {
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 1;
  }

  @action
  void verifyBags(Driver currentDriver) {
    bool checkBagsFinish = true;
    clientList.forEach((element) {
      if (element.check == false) {
        checkBagsFinish = false;
      }
    });
    if (checkBagsFinish == true) {
      screenState.value = RoutePageState.bagsChecked;
    }
  }

  @action
  void verifyPhotosSent() {
    bool routeFinish = true;
    orderList.forEach((order) {
      if (order.status != OrderStatus.DELIVERED) {
        routeFinish = false;
      }
    });
    if (routeFinish == true) {
      goToRouteDoneScreen();
    }
  }
}
