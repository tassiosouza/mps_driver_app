
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../models/Coordinates.dart';

class GeocodingApi {
  static String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyBtiYdIofNKeq0cN4gRG7L1ngEgkjDQ0Lo&address=';
  
  GeocodingApi()
  {
  }

  Future<Coordinates> getCoordinates(String address) async {

    var response = await http.get(Uri.parse(baseUrl + address));
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);
    var lat = data["results"][0]["geometry"]["location"]["lat"];
    var long = data["results"][0]["geometry"]["location"]["lng"];
    return new Coordinates(lat,long);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    return new Coordinates(0,0);
  }
}