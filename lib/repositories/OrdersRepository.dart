import 'dart:developer';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import '../../models/Todo.dart';
import '../models/Driver.dart';

class OrdersRepository {
  Future<MOrder?> updateOrder(MOrder updatedOrder) async {
    try {
      final request = ModelMutations.update(updatedOrder);
      final response = await Amplify.API.mutate(request: request).response;

      final order = response.data;
      if (order == null) {
        if (response.errors.isNotEmpty) {
          log('errors: ${response.errors}');
          return null;
        }
      }
      return order;
    } on ApiException catch (e) {
      log('Mutation failed: $e');
    }
    return null;
  }

  Future<List<MOrder?>> fetchOrders(List<MRoute?>? routes) async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      List<MOrder?> resultOrders = <MOrder?>[];
      for (int i = 0; i < routes!.length; i++) {
        final queryPredicate = MOrder.ASSIGNEDROUTEID.eq(user.userId);
        final request =
            ModelQueries.list(MOrder.classType, where: queryPredicate);
        final response = await Amplify.API.query(request: request).response;

        if (response.errors.isNotEmpty) {
          log('errors: ${response.errors}');
          return <MOrder>[];
        }

        resultOrders.addAll(response.data!.items);
      }

      return resultOrders;
    } on ApiException catch (e) {
      log('Query failed: $e');
    }
    return <MOrder?>[];
  }
}
