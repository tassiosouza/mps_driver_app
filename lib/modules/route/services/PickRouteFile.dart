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
import 'package:mps_driver_app/models/OrderStatus.dart';
import '../../../../models/Client.dart';
import '../../../models/Customer.dart';
import '../../../models/MpsOrder.dart';
import '../../../models/Route.dart' as route_model;

class PickRouteFile {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  List<Client> _clientList = [];
  List<Client> _clientListResult = [];
  String? _extension;

  Future<List<MpsOrder>> readOrdersFromFile(route_model.Route route) async {
    // Select external csv file from storage
    String selectedCsvFilePath = await selectExternalFile();
    _fileName = selectedCsvFilePath;
    // Read the fields from csv file loaded
    final fields = await extractFileFields(selectedCsvFilePath);
    // Create orders and customers from extracted fields
    List<MpsOrder> orders = createOrdersFromFields(fields, route);
    // Optimize orders using google geocoding api and graphhooper api
    orders = await processOptimizedOrders(orders);

    return orders;
  }

  Future<List<MpsOrder>> processOptimizedOrders(List<MpsOrder> orders) async {
    List<MpsOrder> result = [];
    GeocodingApi geocodingApi = GeocodingApi();
    for (var i = 0; i < orders.length; i++) {
      Future<Coordinates> coordinates =
          geocodingApi.getCoordinates(orders[i].customer!.address);

      await coordinates.then((data) async {
        orders[i] = orders[i].copyWith(
            customer: orders[i]
                .customer
                ?.copyWith(coordinates: data, customerCoordinatesId: data.id));
        if (i == orders.length - 1) {
          //call optimize api using coordinates

          RouteOptimizationApi routeOptimizationApi = RouteOptimizationApi();

          Future<List<MpsOrder>> sortedOrders =
              routeOptimizationApi.getSortedOrders(orders);

          await sortedOrders.then((data) {
            result = data.cast<MpsOrder>();
          }, onError: (e) {
            log(e);
          });
        }
      }, onError: (e) {
        log(e);
      });
    }
    return result;
  }

  Future<List<List>> extractFileFields(String filePath) async {
    final routeFile = File(filePath);
    final input = routeFile.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    return fields;
  }

  Future<String> selectExternalFile() async {
    String filePath = "";
    List<PlatformFile>? paths;

    try {
      paths = (await FilePicker.platform.pickFiles(
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

    filePath = paths != null
        ? paths!.map((e) => e.path).toList()[0].toString()
        : '...';

    return filePath;
  }

  createOrdersFromFields(List<List<dynamic>> fields, route_model.Route route) {
    List<MpsOrder> result = [];
    for (var i = 5; i < fields.length; i += 2) {
      var orderId = extractClientId(fields[i][2].toString());
      var customerName = extractClientName(fields[i][2].toString());
      var customerPhone = extractClientPhone(fields[i][4].toString());
      var customerAddress = fields[i][5].toString();
      var orderDeliveryInstruction = fields[i + 1][5].toString();
      var orderMealsInstruction = fields[i + 1][2].toString() != ""
          ? fields[i + 1][2].toString()
          : "N/A";
      Customer customer = Customer(
          name: customerName, address: customerAddress, phone: customerPhone);
      MpsOrder order = MpsOrder(
          number: orderId,
          routeID: route.id,
          customer: customer,
          deliveryInstruction: orderDeliveryInstruction,
          mealsInstruction: orderMealsInstruction,
          mpsOrderCustomerId: customer.id,
          status: OrderStatus.RECEIVED);
      result.add(order);
    }
    return result;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String extractClientId(String text) {
    String result = '';
    int maxIdCharacters = 7;
    var sharpIndex = text.indexOf('#');
    for (int i = sharpIndex; i < sharpIndex + maxIdCharacters; i++) {
      if (isNumeric(text[i]) || text[i] == '#') {
        result = result + text[i];
      } else {
        return result;
      }
    }
    return result;
  }

  String extractClientName(String text) {
    if (text.contains("NEW - ")) {
      text = "${text.replaceAll("NEW - ", '')} (New)";
    }
    if (text.contains("Female - ")) {
      text = "${text.replaceAll("Female - ", '')} (Female)";
    }
    if (text.contains("Male - ")) {
      text = "${text.replaceAll("Male - ", '')} (Male)";
    }
    if (text.contains("Star Sticker - ")) {
      text = "${text.replaceAll("Star Sticker - ", '')} (Star Sticker)";
    }
    text = text.replaceAllMapped(RegExp("\\([^()]*\\)"), (match) => '');

    return text;
  }

  String extractClientPhone(String text) {
    text = text.replaceAll(' ', '');

    return text;
  }

  getClientsList(List<List<dynamic>> fields) {
    for (var i = 5; i < fields.length; i += 2) {
      Client client = Client();
      client.id = extractClientId(fields[i][2].toString());
      client.name = extractClientName(fields[i][2].toString());
      client.phone = extractClientPhone(fields[i][4].toString());
      client.address = fields[i][5].toString();
      client.deliveryInstructions = fields[i + 1][5].toString();
      client.mealInstructions = fields[i + 1][2].toString();
      client.check = false;
      _clientList.add(client);
    }
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

  String? getFileName() {
    return _fileName;
  }
}
