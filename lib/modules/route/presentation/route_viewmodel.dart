import 'package:mps_driver_app/modules/route/services/PickRouteFile.dart';
import 'package:mps_driver_app/modules/route/services/TwilioService.dart';
import 'package:mps_driver_app/modules/route/utils/RoutePageState.dart';
import '../../../models/Client.dart';
import 'package:mobx/mobx.dart';

import '../../../models/Driver.dart';
part 'route_viewmodel.g.dart';

class RouteViewModel = _RouteViewModel with _$RouteViewModel;

abstract class _RouteViewModel with Store {
  PickRouteFile pickRouteFile = PickRouteFile();

  @observable
  var screenState = Observable(RoutePageState.routePlan);

  @observable
  var firstOpen = Observable(true);

  @action
  void setFirstOpen() {
    firstOpen.value = false;
  }

  @observable
  var clientList = ObservableList<Client>();

  @observable
  var statusRouteBar = Observable(0);

  @action
  Future<void> getClientList() async {
    clientList.addAll(await pickRouteFile.pickFiles());
    goToRouteScreen();
  }

  @action
  void goToRouteScreen() {
    screenState.value = RoutePageState.routePlan;
  }

  @action
  void goToBagsScreen() {
    screenState.value = RoutePageState.bagsChecking;
    statusRouteBar.value = 1;
  }

  @action
  void verifyBags(Driver currentDriver) {
    bool checkBagsFinish = true;
    clientList.forEach((element) {
      if (element.check == false) {
        checkBagsFinish = false;
      }
    });
    if (checkBagsFinish == true) {
      screenState.value = RoutePageState.welcomeMessage;
    }
  }

  @action
  void verifyPhotosSent() {
    bool routeFinish = true;
    clientList.forEach((element) {
      if (element.sentPhoto == false) {
        routeFinish = false;
      }
    });
    if (routeFinish == true) {
      goToRouteDoneScreen();
    }
  }

  @action
  void goToInTransitScreen(Driver currentDriver) {
    TwilioSmsService smsService = TwilioSmsService(currentDriver);
    for (var client in clientList) {
      smsService.sendSms(client.name, client.phone, client.eta);
    }
    screenState.value = RoutePageState.inTransit;
    statusRouteBar.value = 2;
  }

  @action
  void goToRouteDoneScreen() {
    clientList.clear();
    firstOpen.value = true;
    screenState.value = RoutePageState.routeDone;
    statusRouteBar.value = 3;
  }
}
