import 'package:mps_driver_app/Services/PickRouteFile.dart';
import 'package:mps_driver_app/pages/StartRoutePage/StartRoutePageState.dart';
import '../../models/Client.dart';
import 'package:mobx/mobx.dart';
part 'start_route_viewmodel.g.dart';

class StartRouteViewModel = _StartRouteViewModel with _$StartRouteViewModel;

abstract class _StartRouteViewModel with Store{

  PickRouteFile pickRouteFile = PickRouteFile();

  @observable
  var screenState = Observable(RoutePageState.init);

  @observable
  var clientList = ObservableList<Client>();

  @observable
  var checkin = Observable(false);

  @observable
  var statusRouteBar = Observable(0);

  @action
  void setCheckIn(){
    checkin.value = true;
  }

  @action
  void checkBag(int index){
    clientList.elementAt(index).check = true;
  }

  @action
  Future<void> getClientList() async {
    clientList.addAll(await pickRouteFile.pickFiles());
    goToRouteScreen();
  }

  @action
  void goToLoadingScreen(){
    screenState.value = RoutePageState.loading;
  }

  @action void goToRouteScreen(){
    screenState.value = RoutePageState.routePlan;
  }

  @action
  void goToBagsScreen(){
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 1;
  }

  @action
  void goToInTransitScreen(){
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 2;
  }

  @action
  void goToRouteDoneScreen(){
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 3;
  }

  @action void goToInitScreen(){
    screenState.value = RoutePageState.init;
    statusRouteBar.value = 0;
  }

}