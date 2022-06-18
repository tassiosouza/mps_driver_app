import '../models/Client.dart';
import 'dart:convert';

class Utils {
  static List<Map<String, Object>> getJsonBody(List<Client> clients) {
    List<Map<String, Object>> destinationsMap = [];
    for (var i = 0; i < clients.length; i++) {
      Map<String, Object> destinationMap = {
        "id": clients[i].name,
        "name": clients[i].name,
        "address": {
          "location_id": clients[i].name,
          "lon": clients[i].coordinates.longitude,
          "lat": clients[i].coordinates.latitude
        }
      };
      destinationsMap.add(destinationMap);
    }
    return destinationsMap;
  }
}