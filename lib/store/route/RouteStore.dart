import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_place/google_place.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/models/MOrder.dart';
import 'package:mps_driver_app/models/RouteStatus.dart';
import 'package:mps_driver_app/models/Todo.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';
import 'package:mps_driver_app/repositories/RoutesRepository.dart';
import '../../../models/Driver.dart';
import '../../models/MRoute.dart';
import '../../repositories/DriverRepository.dart';
import '../../repositories/OrdersRepository.dart';
import '../main/MainStore.dart';

part 'RouteStore.g.dart';

class RouteStore = _RouteStore with _$RouteStore;

abstract class _RouteStore with Store {
  RoutesRepository routesRepository = RoutesRepository();
  OrdersRepository ordersRepository = OrdersRepository();
  DriverRepository driverRepository = DriverRepository();

  @observable
  List<MRoute?>? routes;

  @observable
  List<MOrder?>? orders;

  @observable
  List<MOrder?>? routeOrders;

  @observable
  Driver? currentDriver;

  @observable
  MRoute? assignedRoute;

  @observable
  bool loading = false;

  @observable
  String? checkIn;

  @action
  setCheckIn(String checkInTime){
    checkIn = checkInTime;
  }

  @action
  setLoading(bool isLoading) {
    loading = isLoading;
  }

  @action
  retrieveRouteOrders() async {
    if (assignedRoute == null) {
      log('The assigned route is necessary to retrive route orders');
    }

    // ** Retrive orders from the assigned route
    routeOrders = await ordersRepository.fetchOrders([assignedRoute]);
    routeOrders!.sort((a, b) => a!.sort!.compareTo(b!.sort!));
  }

  @action
  retrieveDriverInformation() async {
    Driver? driver = await driverRepository.retrieveDriver();
    if (driver == null) {
      log('An error occurred while retrieving driver information');
    }
    // ** Update driver information in mobile store
    currentDriver = driver;
  }

  @action
  updateDriver(Driver driver) async {
    currentDriver = await driverRepository.updateDriver(driver);
  }

  @action
  setEmptyHistory() {
    routes = [];
    orders = [];
  }

  @action
  fetchRoutes() async {
    routes = await routesRepository.fetchRoutes();
  }

  @action
  fetchAssignedRoute() async {
    List<MRoute?> routes = await routesRepository.fetchRoutes();
    assignedRoute = routes.firstWhere(
        (route) =>
            route!.status != RouteStatus.PLANNED &&
            route.status != RouteStatus.DONE &&
            route.status != RouteStatus.CANCELED &&
            route.status != RouteStatus.ON_HOLD,
        orElse: () => null);
  }

  @action
  updateAssignedRoute(MRoute updatedRoute) async {
    assignedRoute = await routesRepository.updateRoute(updatedRoute);
  }

  @action
  updateAssignedRouteOrder(int orderIndex, MOrder? updatedOrder) async {
    List<MOrder?> updatedList = [];
    MOrder? serverNewOrder = await ordersRepository.updateOrder(updatedOrder!);
    for (int i = 0; i < routeOrders!.length; i++) {
      if (i != orderIndex) {
        updatedList.add(routeOrders![i]);
      } else {
        updatedList.add(serverNewOrder);
      }
    }
    routeOrders = updatedList;
  }

  @action
  fetchOrders() async {
    if (routes != null) {
      orders = await ordersRepository.fetchOrders(routes);
    } else {
      log('Orders can only be fetched after routes fetching');
    }
  }

  @observable
  bool finishLoadingHistory = false;

  setFinishLoadingHistory(bool finish) {
    finishLoadingHistory = finish;
  }

  @action
  void cleanLocalData() {
    routes = null;
  }
}
