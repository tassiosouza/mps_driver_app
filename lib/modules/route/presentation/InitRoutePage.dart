// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/RouteStatus.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import '../../../models/MpsOrder.dart';
import '../../../theme/app_colors.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../../models/Route.dart' as route_model;
import '../services/PickRouteFile.dart';

class InitRoutePage extends StatefulWidget {
  const InitRoutePage({Key? key}) : super(key: key);

  @override
  _InitRoutePage createState() => _InitRoutePage();
}

class _InitRoutePage extends State<InitRoutePage> {
  Driver? _currentDriver;
  late StreamSubscription<QuerySnapshot<route_model.Route>> _subscription;
  PickRouteFile pickRouteFile = PickRouteFile();

  @override
  void initState() {
    Driver? driver;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Amplify.DataStore.start();
      driver = await loadDriverInformation();

      _subscription =
          Amplify.DataStore.observeQuery(route_model.Route.classType)
              .listen((QuerySnapshot<route_model.Route> snapshot) {
        for (route_model.Route route in snapshot.items) {
          if (route.routeDriverId == driver!.id &&
              (route.status != RouteStatus.DONE &&
                  route.status != RouteStatus.ABORTED)) {
            Modular.to.navigate('./inroute');
            _subscription.cancel();
          }
        }
      });
    });

    super.initState();
  }

  Future<Driver?> loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentDriver = driver;
      });
    });
    return driver;
  }

  Future<void> uploadRoute() async {
    route_model.Route route = route_model.Route(
        name: "R100 - ${_currentDriver!.name}",
        routeDriverId: _currentDriver!.id,
        status: RouteStatus.PLANNED,
        driver: _currentDriver);

    var orderList = await pickRouteFile.readOrdersFromFile(route);

    route =
        route.copyWith(orders: orderList, name: pickRouteFile.getFileName());

    uploadRouteToAmplify(route);
  }

  Future<void> uploadRouteToAmplify(route_model.Route route) async {
    for (MpsOrder order in route.orders!) {
      await Amplify.DataStore.save(order.customer!.coordinates!);
      await Amplify.DataStore.save(order.customer!);
      await Amplify.DataStore.save(order);
    }
    await Amplify.DataStore.save(route);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Image(
              image: AssetImage('assets/images/initNewRouteScreen.png')),
          const SizedBox(height: 48),
          Text(
            "Upload your route",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: App_Colors.black_text.value,
                fontFamily: 'Poppins',
                decoration: TextDecoration.none),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Please, upload the route you received from the logistics team",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: App_Colors.grey_text.value,
                    fontSize: 16,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            height: 70,
          ),
          Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () => uploadRoute(),
                style: ElevatedButton.styleFrom(
                    primary: App_Colors.primary_color.value),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CustomIcon.upload_icon, size: 20),
                          SizedBox(width: 20),
                          Text("Upload route",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Poppins')),
                        ])),
              ))
        ],
      ),
    );
  }
}
