// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_place/google_place.dart';
import 'package:mps_driver_app/store/route/RouteStore.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../../components/AppDialogs.dart';
import '../../../theme/app_colors.dart';

class InitRoutePage extends StatefulWidget {
  const InitRoutePage({Key? key}) : super(key: key);

  @override
  createState() => _InitRoutePage();
}

class _InitRoutePage extends State<InitRoutePage> {
  bool _isCustomSelected = false;
  String _customAddress = 'Custom';
  late GooglePlace googlePlace;
  final _routeStore = Modular.get<RouteStore>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_routeStore.assignedRoute != null) {
        Modular.to.navigate('./inroute');
      }
      googlePlace = GooglePlace('AIzaSyBtiYdIofNKeq0cN4gRG7L1ngEgkjDQ0Lo');
    });

    super.initState();
  }

  Future<void> chooseEndAddressDialog() {
    return AppDialogs().showDialogJustMsg(context, "Attention",
        "Chose a correct address or check Meal Prep Sunday to load your route.");
  }

  Future<void> getCustomAddress() {
    return AppDialogs().showSelectAddressDialog(
        context,
        googlePlace,
        (address) => {
              log('address set'),
              setState(() {
                _customAddress = address;
                _isCustomSelected = true;
              })
            });
  }

  void fetchAssignedRoute() async {
    _routeStore.setLoading(true);
    await _routeStore.fetchAssignedRoute();
    if (_routeStore.assignedRoute != null) {
      Modular.to.navigate('./inroute');
    }
    _routeStore.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Material(
            child: _routeStore.loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.green))
                : Column(
                    children: [
                      const SizedBox(height: 60),
                      const Expanded(
                        flex: 5,
                        child: Image(
                            image: AssetImage(
                                'assets/images/initNewRouteScreen.png')),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Upload your route",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: App_Colors.black_text.value,
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text(
                              "Please select your final destination and upload the route file.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: App_Colors.grey_text.value,
                                  fontSize: 14,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  activeColor: App_Colors.primary_color.value,
                                  value: !_isCustomSelected,
                                  shape: const CircleBorder(),
                                  checkColor: App_Colors.primary_color.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCustomSelected = false;
                                      _customAddress = 'Custom';
                                    });
                                  }),
                              GestureDetector(
                                  child: SizedBox(
                                      width: 150,
                                      child: Text('Meal Prep Sunday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  App_Colors.grey_dark.value))),
                                  onTap: () => {})
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  activeColor: App_Colors.primary_color.value,
                                  value: _isCustomSelected,
                                  shape: const CircleBorder(),
                                  checkColor: App_Colors.primary_color.value,
                                  onChanged: (bool? value) {
                                    if (value!) {
                                      getCustomAddress();
                                    }
                                  }),
                              GestureDetector(
                                  child: SizedBox(
                                      width: 150,
                                      child: Text(_customAddress,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  App_Colors.grey_dark.value))),
                                  onTap: () => {})
                            ]),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => fetchAssignedRoute(),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      App_Colors.primary_color.value),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          left: 80,
                                          right: 80,
                                          top: 10,
                                          bottom: 10)),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(CustomIcon.upload_icon, size: 20),
                                      SizedBox(width: 20),
                                      Text("Upload route",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins')),
                                    ]),
                              ),
                            ],
                          )),
                      const SizedBox(height: 10)
                    ],
                  )));
  }
}
