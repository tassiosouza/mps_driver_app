import 'dart:developer';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import '../../models/Todo.dart';
import '../models/Driver.dart';

class DriverRepository {
  Future<Todo?> createTodo() async {
    try {
      final todo = Todo(
          name: 'my first todo',
          description: 'todo description',
          isComplete: true,
          owner: '');
      final request = ModelMutations.create(todo);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTodo = response.data;
      if (createdTodo == null) {
        log('errors: ${response.errors}');
        return createdTodo;
      }
      log('Mutation result: ${createdTodo.name}');
    } on ApiException catch (e) {
      log('Mutation failed: $e');
      return null;
    }
  }

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
}
