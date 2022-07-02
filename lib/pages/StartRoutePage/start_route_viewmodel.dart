import 'dart:developer';

import 'package:mps_driver_app/Services/PickRouteFile.dart';
import 'package:mps_driver_app/Services/TwilioService.dart';
import 'package:mps_driver_app/pages/StartRoutePage/StartRoutePageState.dart';
import '../../models/Client.dart';
import 'package:mobx/mobx.dart';
part 'start_route_viewmodel.g.dart';

class StartRouteViewModel = _StartRouteViewModel with _$StartRouteViewModel;

abstract class _StartRouteViewModel with Store {
  PickRouteFile pickRouteFile = PickRouteFile();

  @observable
  var screenState = Observable(RoutePageState.init);

  @observable
  var firstOpen = Observable(true);

  @action
  void setFirstOpen(){
    firstOpen.value = false;
  }

  @observable
  var clientList = ObservableList<Client>();

  @observable
  var checkin = Observable(false);

  @observable
  var sentWelcomeMessage = Observable(false);

  @observable
  var statusRouteBar = Observable(0);

  @action
  void setCheckIn() {
    checkin.value = true;
  }

  @action
  Future<void> getClientList() async {
    clientList.addAll(await pickRouteFile.pickFiles());
    goToRouteScreen();
  }

  @action
  void goToLoadingScreen() {
    screenState.value = RoutePageState.loading;
  }

  @action
  void goToRouteScreen() {
    screenState.value = RoutePageState.routePlan;
  }

  @action
  void goToBagsScreen() {
    TwilioSmsService smsService = new TwilioSmsService();
    for (var client in clientList) {
      smsService.sendSms(client.name, client.phone, client.eta);
    }
    sentWelcomeMessage.value = true;
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 1;
  }

  @action
  void verifyBags() {
    bool checkBagsFinish = true;
    clientList.forEach((element) {
      if(element.check == false){
        checkBagsFinish = false;
      }
    });
    if(checkBagsFinish == true){
      goToInTransitScreen();
    }
  }

  @action
  void verifyPhotosSent() {
    bool routeFinish = true;
    clientList.forEach((element) {
      if(element.sentPhoto == false){
        routeFinish = false;
      }
    });
    if(routeFinish == true){
      goToRouteDoneScreen();
    }
  }

  @action
  void goToInTransitScreen() {
    screenState.value = RoutePageState.inTransit;
    statusRouteBar.value = 2;
  }

  @action
  void goToRouteDoneScreen() {
    clientList.clear();
    screenState.value = RoutePageState.routeDone;
    statusRouteBar.value = 3;
  }

  @action
  void goToInitScreen() {
    screenState.value = RoutePageState.init;
    statusRouteBar.value = 0;
  }
}
