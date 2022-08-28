import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/repositories/DriverRepository.dart';
import 'package:workmanager/workmanager.dart';

import '../models/Driver.dart';
import 'location_service.dart';

class BackgroundService{

  late Driver driver;

  Future<void> initBackgroundUpdateDriveLocation(Driver? driver) async {
    driver = driver;
    LocationService locationService = LocationService();
    locationService.initLocation();
    print("initBackgroundUpdateDriveLocation");
    WidgetsFlutterBinding.ensureInitialized();
    //await Workmanager().initialize(() => _initBackgroundTask(driver));
    await _registerPeriodTask();
    print("initBackgroundUpdateDriveLocationFINISH######");
  }

  static void _updateDriveLocation(Driver? driver) async {
    final driverRepositoryBackgroundTask = DriverRepository();

    LocationService locationService = LocationService();
    List<double?> location = await locationService.getLocation();
    if(location.isNotEmpty && location[0] != null && location[1] != null
        && driver != null){
      driverRepositoryBackgroundTask.updateDriver(driver.copyWith(
          latitude: location[0], longitude: location[1]));
    }
    print("TESTING BACKGROUND TASK");
    print(TimeOfDay.now().toString());
  }

  Future<void> _registerPeriodTask() async {
    await Workmanager().registerPeriodicTask("updateDriveLocation", "updateDriveLocation",
        frequency: Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected,
        ));
  }
}

// void _initBackgroundTask(Driver? driver){
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case "updateDriveLocation":
//         BackgroundService._updateDriveLocation(driver);
//         break;
//     }
//     return Future.value(true);
//   });
// }