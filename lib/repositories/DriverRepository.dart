import 'dart:developer';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:workmanager/workmanager.dart';
import '../models/Driver.dart';

class DriverRepository {

  Future<Driver> createDriver(String ownerID) async {
    String amplifyDriverName = '';
    String amplifyDriverEmail = '';
    String amplifyPhoneNumber = '';

    await Amplify.Auth.fetchUserAttributes().then((value) => {
          amplifyDriverName = value
              .firstWhere(
                  (element) => element.userAttributeKey.toString() == 'name')
              .value,
          amplifyDriverEmail = value
              .firstWhere(
                  (element) => element.userAttributeKey.toString() == 'email')
              .value,
          amplifyPhoneNumber = value
              .firstWhere((element) =>
                  element.userAttributeKey.toString() == 'phone_number')
              .value,
        });

    return Driver(
        id: ownerID,
        owner: ownerID,
        name: amplifyDriverName,
        email: amplifyDriverEmail,
        phone: amplifyPhoneNumber,
        carCapacity: 22,
        onBoard: false);
  }

  Future<Driver?> updateDriver(Driver updatedDriver) async {
    try {
      final request = ModelMutations.update(updatedDriver);
      final response = await Amplify.API.mutate(request: request).response;

      final driver = response.data;
      if (driver == null) {
        if (response.errors.isNotEmpty) {
          log('errors: ${response.errors}');
          return null;
        }
      }
      return driver;
    } on ApiException catch (e) {
      log('Mutation failed: $e');
    }
    return null;
  }

  Future<Driver?> retrieveDriver() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final queryPredicate = Driver.OWNER.eq(user.userId);
      final request =
          ModelQueries.list(Driver.classType, where: queryPredicate);
      final response = await Amplify.API.query(request: request).response;

      if (response.errors.isNotEmpty) {
        log('errors: ${response.errors}');
        return null;
      }

      if (response.data!.items.isEmpty) {
        // ** No Driver: Create a new one
        Driver newDriver = await createDriver(user.userId);
        final createRequest = ModelMutations.create(newDriver);
        final createResponse =
            await Amplify.API.query(request: createRequest).response;

        return createResponse.data;
      }

      final driver = response.data!.items.first;
      return driver;
    } on ApiException catch (e) {
      log('Query failed: $e');
    }
    return null;
  }

  Future<void> initBackgroundUpdateDriveLocation(Driver? driver) async {
    // LocationService locationService = LocationService();
    // locationService.initLocation();
    print("initBackgroundUpdateDriveLocation");
    WidgetsFlutterBinding.ensureInitialized();
    await Workmanager().initialize(initBackgroundTask,
    isInDebugMode: true);
    await Workmanager().registerPeriodicTask("updateDriveLocation", "updateDriveLocation",
    frequency: Duration(seconds: 900));
    print("initBackgroundUpdateDriveLocationFINISH######");
  }
}

void updateDriveLocation() async {
  // LocationService locationService = LocationService();
  // List<double?> location = await locationService.getLocation();
  // if(location.isNotEmpty && location[0] != null && location[1] != null){
  //   updateDriver(driver.copyWith(
  //       latitude: location[0], longitude: location[1]));
  // }
  print("TESTING BACKGROUND TASK");
}

void initBackgroundTask(){
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "updateDriveLocation":
        updateDriveLocation();
        break;
    }
    return Future.value(true);
  });
}
