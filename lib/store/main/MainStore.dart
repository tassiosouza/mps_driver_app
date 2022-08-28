import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/Services/background_service.dart';
import 'package:mps_driver_app/Services/location_service.dart';
import 'package:mps_driver_app/models/Todo.dart';
import 'package:mps_driver_app/modules/route/services/ManageEndAddress.dart';
import '../../../models/Driver.dart';
import '../../repositories/DriverRepository.dart';

part 'MainStore.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  DriverRepository driverRepository = DriverRepository();
  BackgroundService backgroundService = BackgroundService();

  // ** Main Store Observables
  @observable
  String error = '';

  @observable
  Driver? currentDriver;

  @observable
  var currentIndex = Observable(2);

  // ** Main Store Actions
  @action
  retrieveDriverInformation() async {
    Driver? driver = await driverRepository.retrieveDriver();
    if (driver == null) {
      log('An error occurred while retrieving driver information');
    }
    // ** Update driver information in mobile store
    currentDriver = driver;
    //await backgroundService.initBackgroundUpdateDriveLocation(driver);
  }

  @action
  clearCurrentDriver() async {
    currentDriver = null;
  }

  @action
  updateDriverInformation(Driver? updatedDriver) async {
    Driver? updatedFromServer =
        await driverRepository.updateDriver(updatedDriver!);
    currentDriver = updatedFromServer;
  }

  @action
  setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
