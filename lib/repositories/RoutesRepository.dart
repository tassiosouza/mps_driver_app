import 'dart:developer';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import '../../models/Todo.dart';
import '../models/Driver.dart';

class RoutesRepository {
  Future<MRoute?> updateRoute(MRoute updatedRoute) async {
    try {
      final request = ModelMutations.update(updatedRoute);
      final response = await Amplify.API.mutate(request: request).response;

      final route = response.data;
      if (route == null) {
        if (response.errors.isNotEmpty) {
          log('errors: ${response.errors}');
          return null;
        }
      }
      return route;
    } on ApiException catch (e) {
      log('Mutation failed: $e');
    }
    return null;
  }

  Future<List<MRoute?>> fetchRoutes() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final queryPredicate = MRoute.DRIVERID.eq(user.userId);
      final request =
          ModelQueries.list(MRoute.classType, where: queryPredicate);
      final response = await Amplify.API.query(request: request).response;

      if (response.errors.isNotEmpty) {
        log('errors: ${response.errors}');
        return <MRoute>[];
      }

      final routes = response.data!.items;
      return routes;
    } on ApiException catch (e) {
      log('Query failed: $e');
    }
    return <MRoute>[];
  }
}
