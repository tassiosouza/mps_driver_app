import 'dart:developer';
import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mps_driver_app/Services/RouteOptimizationService.dart';
import 'package:mps_driver_app/Services/GoogleGeolocationService.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import '../../../../models/Client.dart';

class PickRouteFile {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String _filePath = "";
  List<Client> _clientList = [];
  List<Client> _clientListResult = [];
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
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    print(fields);

    getClientsList(List<List<dynamic>> fields) {
      for (var i = 1; i < fields.length; i++) {
        Client client = Client();
        client.id = fields[i][0].toString();
        client.name = fields[i][1].toString();
        client.phone = fields[i][2].toString();
        client.address = fields[i][3].toString();
        client.secondAddress = fields[i][4].toString();
        client.city = fields[i][5].toString();
        client.stateZipCode = fields[i][6].toString();
        client.deliveryInstructions = fields[i][7].toString();
        client.mealInstructions = fields[i][8].toString();
        client.check = false;
        _clientList.add(client);
      }
    }

    getClientsList(fields);

    GeocodingApi geocodingApi = GeocodingApi();
    for (var i = 0; i < _clientList.length; i++) {
      Future<Coordinates> coordinates = geocodingApi.getCoordinates(
              _clientList[i].address + " " + _clientList[i].stateZipCode)
          as Future<Coordinates>;

      await coordinates.then((data) async {
        _clientList[i].coordinates = data;
        if (i == _clientList.length - 1) {
          //call optimize api using coordinates

          RouteOptimizationApi routeOptimizationApi = RouteOptimizationApi();

          Future<List<Client>> orderedClients =
              routeOptimizationApi.getOrderedClients(_clientList);

          await orderedClients.then((data) {
            _clientList = data;
          }, onError: (e) {
            log(e);
          });
        }
      }, onError: (e) {
        log(e);
      });
    }

    _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    _clientList = _clientList;
    _clientListResult = _clientList;
    _clientList = [];
    return _clientListResult;
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
