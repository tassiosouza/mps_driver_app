import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/Coordinates.dart';

class GeocodingApi {
  static String baseUrl =
      'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyBtiYdIofNKeq0cN4gRG7L1ngEgkjDQ0Lo&address=';

  GeocodingApi() {}

  Future<Coordinates> getCoordinates(String address) async {
    final split = address.split(',');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };

    var response = await http
        .get(Uri.parse("$baseUrl${values[0]},${values[values.length - 1]}"));
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        var lat = data["results"][0]["geometry"]["location"]["lat"];
        var long = data["results"][0]["geometry"]["location"]["lng"];
        return Coordinates(latitude: lat, longitude: long);
      } catch (e) {
        // ignore: use_build_context_synchronously
        throw Exception('Could not locate: $address');
      }
    } else {
      // ignore: use_build_context_synchronously
      throw Exception('Could not locate: $address');
    }
  }
}
