import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/theme/app_colors.dart';

import '../pages/StartRoutePage/start_route_viewmodel.dart';

class AppDialogs {
  Future<void> showDialogJustMsg(
      BuildContext context, String title, String text) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              alignment: Alignment.center,
              insetPadding: EdgeInsets.only(
                  top: height / 3.1, bottom: height / 3.1,
                  left: width / 10, right: width / 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Container(child: Text(title,
                          style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                      padding: EdgeInsets.only(top: 25),
                    ),
                    Container(child: Text(text,
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        textAlign: TextAlign.justify,
                      ),
                      padding: EdgeInsets.only(left: 30, right: 30),
                    ),
                    Container(child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: App_Colors.primary_color.value),
                        onPressed: () => Navigator.pop(context), child: Text("OK"),
                      ),
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                  ]));
        });
  }

  Future<void> showConfirmDialog(
      BuildContext context, Function function, String title, String text) async {
    final width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Flexible(child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              alignment: Alignment.center, insetPadding: EdgeInsets.only(
              left: width / 10, right: width / 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Container(child: Text(title,
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                    padding: EdgeInsets.only(top: 25),
                  ),
                    SizedBox(height: 20),
                    Container(child: Text(text,
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins',
                        height: 0),
                        textAlign: TextAlign.justify),
                      padding: EdgeInsets.only(left: 30, right: 30),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Container(
                        child: ElevatedButton(style: ElevatedButton.styleFrom(
                            primary: App_Colors.grey_light.value),
                          onPressed: () => Navigator.pop(context),
                          child: Text("CANCEL",
                            style: TextStyle(color: App_Colors.grey_dark.value),
                          ),
                        ),
                        padding: EdgeInsets.only(bottom: 15),
                      ),
                        SizedBox(width: 20),
                        Container(child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: App_Colors.primary_color.value),
                          onPressed: (){
                            function();
                            Navigator.pop(context);
                          },
                          child: Text("CONFIRM"),
                        ),
                          padding: EdgeInsets.only(bottom: 15),
                        ),
                      ],
                    ),
                  ])));
        });
  }
}
