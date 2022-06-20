import 'package:mps_driver_app/Services/PickRouteFile.dart';

import '../../models/Client.dart';
import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/shared/ScreenState.dart';
part 'start_route_viewmodel.g.dart';

class StartRouteViewModel = _StartRouteViewModel with _$StartRouteViewModel;

abstract class _StartRouteViewModel with Store{

  PickRouteFile pickRouteFile = PickRouteFile();

  @observable
  var screenState = Observable(ScreenState.init);

  @observable
  var clientList = Observable(<Client>[]);

  @action
  Future<void> getClientList() async {
    clientList.value = await pickRouteFile.pickFiles();
    goToRouteScreen();
  }

  @action
  void goToLoadingScreen(){
    screenState.value = ScreenState.loading;
  }

  @action void goToRouteScreen(){
    screenState.value = ScreenState.success;
  }

  @action void goToInitScreen(){
    screenState.value = ScreenState.init;
  }

}