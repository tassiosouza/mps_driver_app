import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/Client.dart';
import '../theme/app_colors.dart';

class InstructionsDialog {
  Client client = Client();

  Future<void> call(
      BuildContext context, Client client) async {
    final width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Flexible(child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              alignment: Alignment.center,
              insetPadding: EdgeInsets.only(
                  left: width / 10, right: width / 10),
              child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(child: Text("Delivery Instructions",
                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                    padding: EdgeInsets.only(top: 15)),
                    Divider(thickness: 1, height: 30),
                    SizedBox(height: 8),
                    Row(children: [
                      SizedBox(width: 20),
                      Text("Address 1", style: TextStyle(color: App_Colors.primary_color.value,
                      fontSize: 14, fontFamily: 'Poppins')),
                      SizedBox(width: 10),
                      Text(client.address, style: TextStyle(fontSize: 14,
                          fontFamily: 'Poppins'),)
                    ],),
                    SizedBox(height: 8),
                    Row(children: [
                      SizedBox(width: 20),
                      Text("Address 2", style: TextStyle(color: App_Colors.primary_color.value,
                          fontSize: 14, fontFamily: 'Poppins')),
                      SizedBox(width: 10),
                      Text(client.secondAddress, style: TextStyle(fontSize: 14,
                          fontFamily: 'Poppins'),)
                    ],),
                    SizedBox(height: 8),
                    Row(children: [
                      SizedBox(width: 20),
                      Text("City", style: TextStyle(color: App_Colors.primary_color.value,
                          fontSize: 14, fontFamily: 'Poppins')),
                      SizedBox(width: 10),
                      Text(client.city, style: TextStyle(fontSize: 14,
                          fontFamily: 'Poppins'),),
                      SizedBox(width: 20),
                      Text("Zip code", style: TextStyle(color: App_Colors.primary_color.value,
                          fontSize: 14, fontFamily: 'Poppins')),
                      SizedBox(width: 10),
                      Text(client.stateZipCode, style: TextStyle(fontSize: 14,
                          fontFamily: 'Poppins'),)
                    ],),
                    SizedBox(height: 27),
                    Container(child: Text(client.deliveryInstructions,
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      textAlign: TextAlign.justify),
                      padding: EdgeInsets.only(left: 30, right: 30)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [SizedBox(width: 5), Container(child: Image(image:
                    AssetImage('assets/images/deliveryinstructionsimage.png')),
                      padding: EdgeInsets.all(10),)],)
                  ])));
        });
  }
}