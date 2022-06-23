import '../models/Driver.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'dart:developer';

class DriverService {
  static final DriverService _instance = DriverService._internal();
  static Driver? _driver;

  factory DriverService() {
    return _instance;
  }
  DriverService._internal();

  static login() async {
    await retrieveDriverFromAmplify();
  }

  static Future<Driver?> getCurrentDriver() async {
    if (_driver == null) {
      await retrieveDriverFromAmplify();
    }
    return _driver;
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
      List<Driver> driversQueryResult = await Amplify.DataStore.query(
          Driver.classType,
          where: Driver.OWNER.eq(amplifyDriverId));

      if (driversQueryResult.isEmpty) {
        await createNewAmplifyDriver(amplifyDriverId!, amplifyDriverName,
            amplifyDriverEmail, amplifyPhoneNumber);
        driversQueryResult = await Amplify.DataStore.query(Driver.classType,
            where: Driver.OWNER.eq(amplifyDriverId));
      }

      _driver = driversQueryResult[0];
      return _driver;
    } catch (e) {
      print("Could not query DataStore: " + e.toString());
    }
    return null;
  }

  static Future<void> createNewAmplifyDriver(
      String driverId, String name, String email, String phone) async {
    final item = Driver(
      firstName: name,
      email: email,
      owner: driverId,
      phone: phone,
      carCapacity: '22',
    );
    await Amplify.DataStore.save(item);
  }

  static void logout() {
    _driver = null;
  }
}
