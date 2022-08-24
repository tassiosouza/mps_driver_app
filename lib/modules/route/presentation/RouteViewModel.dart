import 'package:google_place/google_place.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/Services/DriverService.dart';
import 'package:mps_driver_app/models/MRoute.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../../models/Driver.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

import '../../../models/MOrder.dart';
import '../../../models/RouteStatus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../store/main/MainStore.dart';
part 'RouteViewModel.g.dart';

class RouteViewModel = _RouteViewModel with _$RouteViewModel;

abstract class _RouteViewModel with Store {
  ManageEndAddress manageEndAddress = ManageEndAddress();
  final _mainStore = Modular.get<MainStore>();

  @observable
  MRoute? lastActivedRoute = null;

  @action
  setlastActivedRoute(MRoute? route) {
    lastActivedRoute = route;
  }

  @observable
  List<MRoute>? routesHistory = null;

  @action
  setEmptyHistory() {
    routesHistory = [];
  }

  @action
  addToRoutesHistory(MRoute? route) {
    routesHistory ??= [];
    routesHistory!.add(route!);
  }

  @observable
  bool finishLoadingHistory = false;

  setFinishLoadingHistory(bool finish) {
    finishLoadingHistory = finish;
  }

  @action
  void cleanLocalData() {
    lastActivedRoute = null;
    routesHistory = null;
  }

  syncAmplifyData() async {
    // await Amplify.DataStore.clear();
    // await Amplify.DataStore.stop();
    // await Amplify.DataStore.start();
  }

  @observable
  Driver? currentDriver;

  @action
  fetchCurrentDriver() async {
    currentDriver = _mainStore.currentDriver;
    return currentDriver;
  }

  @action
  updateDriverInformation(Driver? driver) async {
    currentDriver = driver;
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
