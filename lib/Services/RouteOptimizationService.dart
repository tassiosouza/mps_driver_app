import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/Client.dart';
import '../../utils/getjson.dart';

class RouteOptimizationApi {
  static String baseUrl =
      'https://graphhopper.com/api/1/vrp?key=110bcab4-47b7-4242-a713-bb7970de2e02';

  RouteOptimizationApi() {}

  Future<List<Client>> getOrderedClients(List<Client> clients) async {
    List<Map<String, Object>> object = GetJsonBody.getJsonBody(clients);

    String body = jsonEncode(<String, List<Map<String, Object>>>{
      "vehicles": [
        {
          "vehicle_id": "driver_vehicle",
          "start_address": {
            "location_id": "mps_facility",
            "lon": -117.2310085,
            "lat": 33.1522247
          }
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
      var time = data['solution']['time'];
      var distance = data['solution']['distance'];
      var route = data['solution']['routes'][0]['activities'];
      List<String> orderedLocationsId = [];
      List<int> orderedETAs = [];
      for (int i = 0; i < route.length; i++) {
        orderedLocationsId.add(route[i]['location_id']);
        orderedETAs.add(route[i]['driving_time']);
      }

      List<Client> orderedClients = [];
      for (int i = 1; i <= clients.length; i++) {
        Client findClient(String name) =>
            clients.firstWhere((client) => client.name == name);
        Client client = findClient(orderedLocationsId[i]);
        client.eta = orderedETAs[i];
        orderedClients.add(client);
      }

      return orderedClients;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    return [];
  }
}
