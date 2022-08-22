import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_place/google_place.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/models/Todo.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';
import 'package:mps_driver_app/repositories/RoutesRepository.dart';
import '../../../models/Driver.dart';
import '../../models/MRoute.dart';
import '../../repositories/DriverRepository.dart';
import '../main/MainStore.dart';

part 'HistoryStore.g.dart';

class HistoryStore = _HistoryStore with _$HistoryStore;

abstract class _HistoryStore with Store {
  RoutesRepository routesRepository = RoutesRepository();

  @observable
  List<MRoute?>? routesHistory;

  @action
  setEmptyHistory() {
    routesHistory = [];
  }

  @action
  fetchRoutes() async {
    routesHistory = await routesRepository.fetchRoutes();
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
