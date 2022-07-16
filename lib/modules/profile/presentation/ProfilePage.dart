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

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Driver? _currentDriver;
  final viewModel = Modular.get<ProfileViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDriverInformation();
    });
    getLocalMaps();
  }

  void getLocalMaps() async {
    await viewModel.getMapOptions();
    viewModel.setDefaultMap();
  }

  void loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    setState(() {
      _currentDriver = driver;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _currentDriver != null
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
                                  SizedBox(height: 85),
                                  Container(
                                    padding: EdgeInsets.all(2),
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
                                  SizedBox(height: 15),
                                  Text(
                                    "${_currentDriver?.name}",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text("Driver",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: App_Colors.grey_light.value))
                                ],
                              ),
                            ])),
                    SizedBox(height: 18),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          getInfoColumn('198', "Trips"),
                          getInfoColumn('2', "Month"),
                          getInfoColumn('327', "Deliveries"),
                          getInfoColumn("4.8", "Rating")
                        ]),
                    SizedBox(height: 22),
                    Container(
                        color: App_Colors.grey_background.value,
                        padding: EdgeInsets.only(
                            left: 25, top: 5, right: 25, bottom: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                    SizedBox(height: 15),
                    getInfoRow("Full Name", _currentDriver!.name),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Email", _currentDriver!.email),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Phone number", _currentDriver?.phone),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow(
                        "Car capacity", _currentDriver?.carCapacity.toString()),
                    SizedBox(height: 20),
                    Container(
                        color: App_Colors.grey_background.value,
                        padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                        child: Row(children: [
                          Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ])),
                    SizedBox(height: 20),
                     Container(padding: EdgeInsets.only(bottom: 20, left: 25, right: 25),
                       child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(onTap: () => {ChooseMapDialog().call(context)},
                             child: Container(
                               child:Text("Choose map", style: TextStyle(
                                   color: App_Colors.black_text.value,
                                   fontSize: 14)),
                             )),
                         GestureDetector(child: Container(child: Observer(builder:
                         (_) => Text(viewModel.chosenMap.value.mapName, style:
                         TextStyle(fontSize: 14, fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500, color: App_Colors.black_text.value),
                         ),)), onTap: () => {ChooseMapDialog().call(context)})
                       ]),),
                    getAccountOptions("Change password", (){}),
                    GestureDetector(
                      onTap: () => logout(),
                      child: Container(
                          padding: EdgeInsets.only(left: 25, bottom: 25),
                          child: Row(children: [
                            Text("Logout",
                                style: TextStyle(
                                    color: App_Colors.alert_color.value,
                                    fontSize: 14)),
                          ])),
                    ),
                  ]))
            : Center(child: CircularProgressIndicator()));
  }

  logout() {
    Amplify.Auth.signOut();
    DriverService.logout();
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
      SizedBox(height: 10),
      Text(label, style: TextStyle(fontSize: 14))
    ]);
  }

  getAccountOptions(String text, Function function){
    return GestureDetector(
      onTap: () => {},
      child: Container(
          padding: EdgeInsets.only(left: 25, bottom: 20),
          child: Row(children: [
            Text(text, style: TextStyle(
                    color: App_Colors.black_text.value,
                    fontSize: 14)),
          ])),
    );
  }

  getInfoRow(String label, String? value) {
    TextEditingController myController = new TextEditingController();
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14),
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
                        child: Text(value.toString(), style:
                          TextStyle(fontSize: 14, fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500, color: App_Colors.black_text.value),),
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
