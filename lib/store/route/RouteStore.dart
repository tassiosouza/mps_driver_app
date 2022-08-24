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
  List<MRoute?>? routesHistory;

  @observable
  List<MOrder?>? ordersHistory;

  @observable
  Driver? currentDriver;

  @observable
  MRoute? assignedRoute;

  @observable
  bool loading = false;

  @action
  setLoading(bool isLoading) {
    loading = isLoading;
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
  setEmptyHistory() {
    routesHistory = [];
    ordersHistory = [];
  }

  @action
  fetchRoutes() async {
    routesHistory = await routesRepository.fetchRoutes();
  }

  @action
  fetchAssignedRoute() async {
    List<MRoute?> routes = await routesRepository.fetchRoutes();
    assignedRoute = routes.firstWhere(
        (route) => route!.status == RouteStatus.ASSIGNED,
        orElse: () => null);
  }

  @action
  fetchOrders() async {
    if (routesHistory != null) {
      ordersHistory = await ordersRepository.fetchOrders(routesHistory);
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
    routesHistory = null;
  }
}
