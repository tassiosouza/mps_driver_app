import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_place/google_place.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/models/MOrder.dart';
import 'package:mps_driver_app/models/Todo.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';
import 'package:mps_driver_app/repositories/RoutesRepository.dart';
import '../../../models/Driver.dart';
import '../../models/MRoute.dart';
import '../../models/RouteStatus.dart';
import '../../repositories/DriverRepository.dart';
import '../../repositories/OrdersRepository.dart';
import '../main/MainStore.dart';

part 'HistoryStore.g.dart';

class HistoryStore = _HistoryStore with _$HistoryStore;

abstract class _HistoryStore with Store {
  RoutesRepository routesRepository = RoutesRepository();
  OrdersRepository ordersRepository = OrdersRepository();

  @observable
  List<MRoute?>? routesHistory;

  @observable
  List<MOrder?>? ordersHistory;

  @action
  setEmptyHistory() {
    routesHistory = [];
    ordersHistory = [];
  }

  @action
  fetchRoutes() async {
    var routesList = [];
    routesList = await routesRepository.fetchRoutes();
    routesList.removeWhere((element) => element.status != RouteStatus.DONE);
    routesHistory = routesList as List<MRoute?>?;
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

  @observable
  bool isRouteActived = false;

  @action
  setIsRouteActived(bool actived) {
    isRouteActived = actived;
  }
}
