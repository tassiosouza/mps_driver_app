import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/theme/app_colors.dart';

class ListHistoryOrderItem extends StatelessWidget{
  MpsOrder order;
  ListHistoryOrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(child: Container(child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("#45782"), Text("17:10")
          ]),
      SizedBox(height: 10),
      Text("Jennifer Alef"), Text("202 Island Avenue, CA 92101")
    ], crossAxisAlignment: CrossAxisAlignment.start,),
      padding: EdgeInsets.only(left: 30, right: 40, top: 10, bottom: 10),
    ), color: App_Colors.grey_light.value, margin: EdgeInsets.only(
        right: 15, left: 15, bottom: 5, top: 5), elevation: 0);
  }

}