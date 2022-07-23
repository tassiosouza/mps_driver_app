import '../models/Driver.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'dart:developer';

class DriverService {
  static final DriverService _instance = DriverService._internal();
  static Driver? _driver;

  factory DriverService() {
    return _instance;
  }
  DriverService._internal();

  static Future<Driver?> getCurrentDriver() async {
    _driver ??= await retrieveDriverFromAmplify();
    return _driver;
  }

  static Future<bool> setDriverName(String name) async {
    Driver updatedDriver = _driver!.copyWith(
      name: name,
    );
    bool result = false;

    await Amplify.DataStore.save(updatedDriver)
        .then((driver) => {
              _driver = updatedDriver,
              result = true,
            })
        .catchError((Object error) {
      log('An error occurred trying to update driver name');
      // ignore: invalid_return_type_for_catch_error
      return result = false;
    });
    return result;
  }

  static Future<bool> setDriverPhone(String phone) async {
    Driver updatedDriver = _driver!.copyWith(
      phone: phone,
    );
    bool result = false;

    await Amplify.DataStore.save(updatedDriver)
        .then((driver) => {
              _driver = updatedDriver,
              result = true,
            })
        .catchError((Object error) {
      log('An error occurred trying to update driver phone');
      // ignore: invalid_return_type_for_catch_error
      return result = false;
    });
    return result;
  }

  static Future<bool> setDriverCapacity(int carCapacity) async {
    Driver updatedDriver = _driver!.copyWith(
      carCapacity: carCapacity,
    );
    bool result = false;

    await Amplify.DataStore.save(updatedDriver)
        .then((driver) => {
              _driver = updatedDriver,
              result = true,
            })
        .catchError((Object error) {
      log('An error occurred trying to update driver car capacity');
      // ignore: invalid_return_type_for_catch_error
      return result = false;
    });
    return result;
  }

  static Future<Driver?> retrieveDriverFromAmplify() async {
    String? amplifyDriverId;
    String amplifyDriverName = '';
    String amplifyDriverEmail = '';
    String amplifyPhoneNumber = '';
    int index = 0;
    await Amplify.Auth.getCurrentUser()
        .then((value) => {amplifyDriverId = value.userId});

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

    try {
      List<Driver> driversQueryResult =
          await Amplify.DataStore.query(Driver.classType);

      log("logsecond");

      Driver? registeredDriver;
      for (Driver driver in driversQueryResult) {
        if (driver.owner == amplifyDriverId) {
          registeredDriver = driver;
        }
      }

      if (registeredDriver == null) {
        await createNewAmplifyDriver(amplifyDriverId!, amplifyDriverName,
            amplifyDriverEmail, amplifyPhoneNumber);
        driversQueryResult = await Amplify.DataStore.query(Driver.classType);
        for (Driver driver in driversQueryResult) {
          if (driver.owner == amplifyDriverId) {
            registeredDriver = driver;
          }
        }
      }

      return registeredDriver;
    } catch (e) {
      print("Could not query DataStore: $e");
    }
    return null;
  }

  static Future<void> createNewAmplifyDriver(
      String driverId, String name, String email, String phone) async {
    final item = Driver(
      name: name,
      email: email,
      owner: driverId,
      phone: phone,
      carCapacity: 22,
    );
    await Amplify.DataStore.save(item);
  }

  static void logout() {
    _driver = null;
  }
}
