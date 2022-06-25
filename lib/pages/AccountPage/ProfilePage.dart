import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mps_driver_app/components/Loading.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../Services/DriverService.dart';
import '../../models/Driver.dart';
import '../../theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return ProfilePageState();
  }
}

class ProfilePageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageState> {
  Driver? _currentDriver;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDriverInformation();
    });

    super.initState();
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
                                    "${_currentDriver?.firstName}",
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
                          getInfoColumn("4.8", "Rating"),
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
                    getInfoRow("Full Name", _currentDriver!.firstName),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Email", _currentDriver!.email),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Phone number", _currentDriver?.phone),
                    Divider(thickness: 1, color: App_Colors.grey_light.value),
                    getInfoRow("Car Capacity", _currentDriver?.carCapacity),
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
                    SizedBox(height: 25),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Row(children: [
                            Text("Change password",
                                style: TextStyle(fontSize: 14)),
                          ])),
                      onTap: () {},
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.only(left: 25, bottom: 25),
                          child: Row(children: [
                            Text("Logout",
                                style: TextStyle(
                                    color: App_Colors.alert_color.value,
                                    fontSize: 14)),
                          ])),
                      onTap: () {},
                    ),
                  ]))
            : Loading());
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

  getInfoRow(String label, String? value) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
          Text(value ?? '',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
