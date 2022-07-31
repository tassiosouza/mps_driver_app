import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/Client.dart';
import '../../../../models/MpOrder.dart';
import '../../../../theme/app_colors.dart';

class InstructionsDialog {
  Future<void> call(BuildContext context, MpOrder order) async {
    final width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              alignment: Alignment.center,
              insetPadding:
                  EdgeInsets.only(left: width / 10, right: width / 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    child: Text("Delivery Instructions",
                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                    padding: EdgeInsets.only(top: 15)),
                Divider(thickness: 1, height: 30),
                SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text("Address",
                        style: TextStyle(
                            color: App_Colors.primary_color.value,
                            fontSize: 14,
                            fontFamily: 'Poppins'))
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                        child: Column(children: [
                      RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: order.customer!.address,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: App_Colors.black_text.value,
                                  fontFamily: 'Poppins')))
                    ])),
                    SizedBox(width: 20)
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text("Instructions",
                        style: TextStyle(
                            color: App_Colors.primary_color.value,
                            fontSize: 14,
                            fontFamily: 'Poppins'))
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                        child: Column(children: [
                      RichText(
                          maxLines: 20,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: order.deliveryInstruction,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: App_Colors.black_text.value,
                                  fontFamily: 'Poppins')))
                    ])),
                    SizedBox(width: 20)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: const Image(
                          image: AssetImage(
                              'assets/images/deliveryinstructionsimage.png')),
                    )
                  ],
                )
              ]));
        });
  }
}
