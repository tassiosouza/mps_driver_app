import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';

import '../../theme/app_colors.dart';

class StartRouteInitPage extends StatefulWidget {
  StartRouteViewModel startRouteViewModel;
  StartRouteInitPage(this.startRouteViewModel);
  _StartRouteInitPage createState() => _StartRouteInitPage();
}

class _StartRouteInitPage extends State<StartRouteInitPage>{

  void getClientList(){
    widget.startRouteViewModel.goToLoadingScreen();
    widget.startRouteViewModel.getClientList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(height: 180,),
        Image(image: AssetImage('assets/images/initNewRouteScreen.png')),
        SizedBox(height: 48),
        Text("Upload your route", style: TextStyle(fontWeight: FontWeight.w600,
            fontSize: 25,
            color: App_Colors.black_text.value,
            fontFamily: 'Poppins',
            decoration: TextDecoration.none),),
        SizedBox(height: 15,),
        Container(padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              "Please, upload the route you received from the logistics team",
              style: TextStyle(fontFamily: 'Poppins',
                  color: App_Colors.grey_text.value, fontSize: 16,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,)),
        SizedBox(height: 70,),
        Container(padding: EdgeInsets.only(left: 30, right: 30),
            child: ElevatedButton(onPressed: () => getClientList(),
              style: ElevatedButton.styleFrom(
                  primary: App_Colors.primary_color.value),
              child: Container(padding: EdgeInsets.all(10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(CustomIcon.upload_icon, size: 20),
                        SizedBox(width: 20),
                        Text("Upload route",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Poppins')),
                      ])),

            ))
      ],),
    );
  }
}