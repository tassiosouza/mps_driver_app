import 'dart:async';
import 'package:map_launcher/map_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapsChooseService{

  late var listMaps;

  FutureOr<List<dynamic>> getMapsList() async {
    listMaps = await MapLauncher.installedMaps;
    if(listMaps != null){
      return listMaps;
    } else {
      return [];
    }
  }

  saveChosenMap(String mapName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('map', mapName);
  }
  Future<String?> getSavedMap() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String mapName = prefs.getString('map') ?? '';
    return mapName;
  }
}