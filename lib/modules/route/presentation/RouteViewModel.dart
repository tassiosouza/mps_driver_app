import 'package:google_place/google_place.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/models/MpsRoute.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';
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
