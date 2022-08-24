import '../models/Client.dart';
import 'dart:convert';

import '../models/MOrder.dart';

class GetJsonBody {
  static List<Map<String, Object>> getJsonBody(List<MOrder> orders) {
    List<Map<String, Object>> destinationsMap = [];
    for (var i = 0; i < orders.length; i++) {
      Map<String, Object> destinationMap = {
        "id": orders[i].customerName!,
        "name": orders[i].customerName!,
        "address": {
          "location_id": orders[i].customerName,
          "lon": orders[i].longitude,
          "lat": orders[i].latitude
        }
      };
      destinationsMap.add(destinationMap);
    }
    return destinationsMap;
  }
}
