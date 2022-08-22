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

part 'RouteStore.g.dart';

class RouteStore = _RouteStore with _$RouteStore;

abstract class _RouteStore with Store {
  ManageEndAddress manageEndAddress = ManageEndAddress();
  RoutesRepository routesRepository = RoutesRepository();
  DriverRepository driverRepository = DriverRepository();

  @observable
  Driver? currentDriver;

  @action
  retrieveDriverInformation() async {
    Driver? driver = await driverRepository.retrieveDriver();
    if (driver == null) {
      log('An error occurred while retrieving driver information');
    }
    // ** Update driver information in mobile store
    currentDriver = driver;
  }

  @observable
  MRoute? lastActivedRoute;

  @action
  setlastActivedRoute(MRoute? route) {
    lastActivedRoute = route;
  }

  @action
  void cleanLocalData() {
    lastActivedRoute = null;
  }

  @observable
  bool isRouteActived = false;

  @action
  setIsRouteActived(bool actived) {
    isRouteActived = actived;
  }

  @observable
  var endAddress = Observable('Meal Prep Sunday');

  @observable
  var predictions = ObservableList();

  @action
  addPredictions(List<AutocompletePrediction> predct) {
    predictions.addAll(predct);
  }

  @action
  clearPredictions() {
    predictions.clear();
  }

  @action
  setEndAddress(String address) {
    endAddress.value = address;
    manageEndAddress.saveEndAddress(address);
  }

  setFirstEndAddress() async {
    var address = await manageEndAddress.getEndAddress();
    setEndAddress(address!);
  }
}
