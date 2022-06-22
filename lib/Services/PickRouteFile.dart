import 'dart:developer';
import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/Services/route_optimization_api';

import 'geocoding_api';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/Services/TwilioSmsService.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import 'dart:developer';
import '../../Services/geocoding_api';
import '../../Services/route_optimization_api';
import '../../components/client_item.dart';
import '../../models/Client.dart';

class PickRouteFile {

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String _filePath = "";
  List<Client> _clientList = [];
  List<PlatformFile>? _paths;
  String? _extension;


  Future<List<Client>> pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }

    _filePath = _paths != null
        ? _paths!.map((e) => e.path).toList()[0].toString()
        : '...';

    final file = File(_filePath);

    // Read the file
    final input = file.openRead();
    final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    print(fields);

    List<Client> getClientsList(List<List<dynamic>> fields){
      List<Client> clients = [];
      Client client = Client();
      for(var element in fields){
          client.id = element[0];
          client.name = element[1];
          client.phone = element[2];
          client.address = element[3];
          client.secondAddress = element[4].toString();
          client.city = element[5];
          client.stateZipCode = element[6];
          client.deliveryInstructions = element[7];
          client.mealInstructions = element[8];
          clients.add(client);
      }
      return clients;
    }
    _clientList.addAll(getClientsList(fields));

    GeocodingApi geocodingApi = new GeocodingApi();
    for (var i = 0; i < _clientList.length; i++) {
      Future<Coordinates> coordinates =
      geocodingApi.getCoordinates(_clientList[i].secondAddress +" "+ _clientList[i].address) as Future<Coordinates>;

      await coordinates.then((data) async {
        _clientList[i].coordinates = data;
        if (i == _clientList.length - 1) {
          //call optimize api using coordinates

          RouteOptimizationApi routeOptimizationApi =
          new RouteOptimizationApi();

          Future<List<Client>> orderedClients =
          routeOptimizationApi.getOrderedClients(_clientList);

          // await orderedClients.then((data) {
          //   _clientList = data;
          // }, onError: (e) {
          //   log(e);
          // });
        }
      }, onError: (e) {
        log(e);
      });
    }

    _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    _clientList = _clientList;

    return _clientList;
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

}