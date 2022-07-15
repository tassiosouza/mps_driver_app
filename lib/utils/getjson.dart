import '../models/Client.dart';
import 'dart:convert';

import '../models/MpsOrder.dart';

class GetJsonBody {
  static List<Map<String, Object>> getJsonBody(List<MpsOrder> orders) {
    List<Map<String, Object>> destinationsMap = [];
    for (var i = 0; i < orders.length; i++) {
      Map<String, Object> destinationMap = {
        "id": orders[i].customer!.name,
        "name": orders[i].customer!.name,
        "address": {
          "location_id": orders[i].customer!.name,
          "lon": orders[i].customer!.coordinates!.longitude,
          "lat": orders[i].customer!.coordinates!.latitude
        }
      };
      destinationsMap.add(destinationMap);
    }
    return destinationsMap;
  }
}
