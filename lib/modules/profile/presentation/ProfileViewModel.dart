import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';
import '../../../Services/MapsChooseService.dart';
part 'ProfileViewModel.g.dart';

class ProfileViewModel = _ProfileViewModel with _$ProfileViewModel;

abstract class _ProfileViewModel with Store{
  final mapsChooseService = MapsChooseService();

  @observable
  var chosenMap = Observable(AvailableMap(
      mapType: MapType.tencent, icon: '', mapName: ''));

  @action
  setChosenMap(AvailableMap map){
    chosenMap.value = map;
    mapsChooseService.saveChosenMap(map.mapName);
  }

  @action
  setDefaultMap() async {
    final savedMap = await mapsChooseService.getSavedMap();
    if(savedMap != ''){
      chosenMapsList.forEach((element) {
        if(element.mapName == savedMap){
          chosenMap.value = element;
        }});
    } else {
      chosenMap.value = chosenMapsList[0];
    }
  }

  @observable
  var chosenMapsList = ObservableList();

  @action
  getMapOptions() async {
    chosenMapsList.clear();
    chosenMapsList.addAll(await mapsChooseService.getMapsList());
  }
}