import 'package:google_place/google_place.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/Services/DriverService.dart';
import 'package:mps_driver_app/models/MpsRoute.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';

import '../../../models/Driver.dart';
part 'RouteViewModel.g.dart';

class RouteViewModel = _RouteViewModel with _$RouteViewModel;

abstract class _RouteViewModel with Store {
  ManageEndAddress manageEndAddress = ManageEndAddress();

  @observable
  MpsRoute? lastActivedRoute = null;

  @action
  setlastActivedRoute(MpsRoute? route) {
    lastActivedRoute = route;
  }

  @observable
  Driver? currentDriver;

  @action
  loadCurrentDriver() async {
    currentDriver ??= await DriverService.getCurrentDriver();
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
