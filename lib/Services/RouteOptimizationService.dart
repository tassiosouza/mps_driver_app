import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:mps_driver_app/models/Coordinates.dart';
import 'dart:convert';
import '../utils/Getjson.dart';
import '../models/MpsOrder.dart';

class RouteOptimizationApi {
  static String baseUrl =
      'https://graphhopper.com/api/1/vrp?key=110bcab4-47b7-4242-a713-bb7970de2e02';
  static Coordinates finalCoordinates =
      Coordinates(latitude: 33.1522247, longitude: -117.2310085);
  static int lastRouteDistance = 0;
  static int lastRouteDuration = 0;

  RouteOptimizationApi();

  Future<List<MpsOrder>> getSortedOrders(List<MpsOrder> orders) async {
    List<Map<String, Object>> object = GetJsonBody.getJsonBody(orders);

    String body = jsonEncode(<String, List<Map<String, Object>>>{
      "vehicles": [
        {
          "vehicle_id": "driver_vehicle",
          "start_address": {
            "location_id": "mps_facility",
            "lon": -117.2310085,
            "lat": 33.1522247
          },
          "end_address": {
            "location_id": "custom",
            "lon": finalCoordinates.longitude,
            "lat": finalCoordinates.latitude
          },
          "move_to_end_address": true,
        }
      ],
      "services": object
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      lastRouteDuration = data['solution']['time'];
      lastRouteDistance = data['solution']['distance'];
      var route = data['solution']['routes'][0]['activities'];
      List<String> orderedLocationsId = [];
      List<int> orderedETAs = [];
      for (int i = 0; i < route.length; i++) {
        orderedLocationsId.add(route[i]['location_id']);
        orderedETAs.add(route[i]['driving_time']);
      }

      List<MpsOrder> sortedOrders = [];
      for (int i = 1; i <= orders.length; i++) {
        MpsOrder findClient(String name) =>
            orders.firstWhere((order) => order.customer!.name == name);
        MpsOrder order = findClient(orderedLocationsId[i]);
        order = order.copyWith(eta: orderedETAs[i]);
        sortedOrders.add(order);
      }

      return sortedOrders;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    return [];
  }

  getLastRouteDistance() {
    return lastRouteDistance;
  }

  getLastRouteDuration() {
    return lastRouteDuration;
  }

  setFinalDestination(Coordinates value) {
    finalCoordinates = value;
  }
}
