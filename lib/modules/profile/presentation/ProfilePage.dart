// ignore_for_file: must_call_super, depend_on_referenced_packages

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/profile/presentation/ProfileViewModel.dart';
import 'package:mps_driver_app/modules/profile/presentation/components/ChooseMapDialog.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import '../../../theme/app_colors.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../route/presentation/RouteViewModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final viewModel = Modular.get<ProfileViewModel>();
  final _routeViewModel = Modular.get<RouteViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    getLocalMaps();
  }

  void getLocalMaps() async {
    await viewModel.getMapOptions();
    viewModel.setDefaultMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _routeViewModel.currentDriver != null
            ? SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Container(
                        height: 250,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/background_profile_img.png'),
                                fit: BoxFit.cover)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 85),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                App_Colors.grey_light.value)),
                                    child: Icon(Icons.person,
                                        size: 90,
                                        color: App_Colors.grey_light.value),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "${_routeViewModel.currentDriver?.name}",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text("Driver",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: App_Colors.grey_light.value))
                                ],
                              ),
                            ])),
                    const SizedBox(height: 18),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          getInfoColumn('198', "Trips"),
                          getInfoColumn('2', "Month"),
                          getInfoColumn('327', "Deliveries"),
                          getInfoColumn("4.8", "Rating")
                        ]),
                    const SizedBox(height: 22),
                    Container(
                        color: App_Colors.grey_background.value,
                        padding: const EdgeInsets.only(
                            left: 25, top: 5, right: 25, bottom: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(fontSize: 12),
                              )
                            ])),
                    const SizedBox(height: 15),
                    getInfoRow(
                        "Full Name", _routeViewModel.currentDriver!.name),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Email", _routeViewModel.currentDriver!.email),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow(
                        "Phone number", _routeViewModel.currentDriver?.phone),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Car capacity",
                        _routeViewModel.currentDriver?.carCapacity.toString()),
                    const SizedBox(height: 20),
                    Container(
                        color: App_Colors.grey_background.value,
                        padding:
                            const EdgeInsets.only(left: 25, top: 5, bottom: 5),
                        child: Row(children: const [
                          Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ])),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 25, right: 25),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () => {ChooseMapDialog().call(context)},
                                child: Text("Choose map",
                                    style: TextStyle(
                                        color: App_Colors.black_text.value,
                                        fontSize: 14))),
                            GestureDetector(
                                child: Observer(
                                  builder: (_) => Text(
                                    viewModel.chosenMap.value.mapName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: App_Colors.black_text.value),
                                  ),
                                ),
                                onTap: () => {ChooseMapDialog().call(context)})
                          ]),
                    ),
                    getAccountOptions("Change password", () {}),
                    GestureDetector(
                      onTap: () => logout(),
                      child: Container(
                          padding: const EdgeInsets.only(left: 25, bottom: 25),
                          child: Row(children: [
                            Text("Logout",
                                style: TextStyle(
                                    color: App_Colors.alert_color.value,
                                    fontSize: 14)),
                          ])),
                    ),
                  ]))
            : const Center(child: CircularProgressIndicator()));
  }

  logout() async {
    Amplify.Auth.signOut();
    await Amplify.DataStore.clear();
    await Amplify.DataStore.stop();
    _routeViewModel.cleanLocalData();
    Modular.to.navigate('/');
  }

  getInfoColumn(String value, String label) {
    return Column(children: [
      Text(
        value,
        style: TextStyle(
            color: App_Colors.black_text.value,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      const SizedBox(height: 10),
      Text(label, style: const TextStyle(fontSize: 14))
    ]);
  }

  getAccountOptions(String text, Function function) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
          padding: const EdgeInsets.only(left: 25, bottom: 20),
          child: Row(children: [
            Text(text,
                style: TextStyle(
                    color: App_Colors.black_text.value, fontSize: 14)),
          ])),
    );
  }

  getInfoRow(String label, String? value) {
    TextEditingController myController = TextEditingController();
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: FocusScope(
                onFocusChange: (value) {
                  if (!value) {
                    log(myController.text.toString());
                  }
                },
                child: TextFormField(
                  controller: myController,
                  onFieldSubmitted: (String value) async {
                    if (value.isNotEmpty) {
                      bool result = false;
                      switch (label) {
                        case 'Full Name':
                          result = await DriverService.setDriverName(value);
                          break;
                        case 'Phone number':
                          result = await DriverService.setDriverPhone(value);
                          break;
                        case 'Car capacity':
                          result = await DriverService.setDriverCapacity(
                              int.parse(value));
                          break;
                      }

                      if (result) {
                        const snackBar = SnackBar(
                          content: Text('User information saved!'),
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      fillColor: Colors.transparent,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      contentPadding: const EdgeInsets.all(0),
                      border: InputBorder.none,
                      label: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: App_Colors.black_text.value),
                        ),
                      ),
                      alignLabelWithHint: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
