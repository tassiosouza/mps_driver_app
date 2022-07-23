import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/Route.dart' as rt;
import 'package:mps_driver_app/theme/app_colors.dart';

import '../../../theme/CustomIcon.dart';

class HistoryRouteListItem extends StatelessWidget{
  rt.Route route;
  HistoryRouteListItem(this.route);

  @override
  Widget build(BuildContext context) {

    String title = "#Route ${route.name}";

    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child: Text("Today", style: TextStyle(fontSize: 12,
              color: App_Colors.grey_text.value)), padding: EdgeInsets.only(left: 20),),
          GestureDetector(child: Container(padding: EdgeInsets.only(top: 5), margin: EdgeInsets.zero,
              child: Card(elevation: 0, margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: App_Colors.grey_light.value)),
                  child: Container(child: IntrinsicHeight(child:
                  Row(children: [
                    Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                      Text(title, style: TextStyle(fontSize: 14, color: App_Colors.primary_color.value,
                          fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      Row(children: [
                        Column(children: [
                          Icon(Icons.location_on_outlined, color: Colors.black, size: 20),
                          Image.asset('assets/images/verticaldots.png', height: 10, scale: 0.2),
                          Icon(Icons.location_on_outlined, color: Colors.black, size: 20)
                        ],),
                        Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Meal Prep Sunday", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 13),
                          Text("202 Island Avenue, CA 92101",
                            style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis,)
                        ]))
                      ],),
                      SizedBox(height: 15),
                      Row(children: [
                        Icon(Icons.watch_later_outlined, size: 18),
                        SizedBox(width: 5),
                        Text("08:00", style: TextStyle(fontSize: 12)),
                        Text(" - ", style: TextStyle(fontSize: 12)),
                        Text("16:00", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 30),
                        Icon(CustomIcon.bag_driver_icon, size: 17),
                        SizedBox(width: 5),
                        Text("22", style: TextStyle(fontSize: 12))
                      ])
                    ]), flex: 13),
                    VerticalDivider(thickness: 1, color: App_Colors.grey_dark.value),
                    Flexible(child: Column(children: [
                      Flexible(child: Column(children: [
                        SizedBox(height: 8),
                        Row(children: [
                          Text("Distance", style: TextStyle(fontSize: 12,
                          color: App_Colors.grey_text.value)),
                          Text("26.2 m", style: TextStyle(fontSize: 12,
                          color: App_Colors.grey_text.value))
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                        SizedBox(height: 10),
                        Row(children: [
                          Text("Time", style: TextStyle(fontSize: 12,
                              color: App_Colors.grey_text.value)),
                          Text("27min", style: TextStyle(fontSize: 12,
                              color: App_Colors.grey_text.value))
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                      ],), flex: 6),
                      Divider(thickness: 1, color: App_Colors.grey_dark.value,),
                      Flexible(child: Column(children: [
                        SizedBox(height: 20),
                        Row(children: [
                          Text("Total", style: TextStyle(fontSize: 12)),
                          Text("\$40.00", style: TextStyle(fontSize: 12,
                              color: App_Colors.primary_color.value, fontWeight: FontWeight.w500))
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                      ],), flex: 4)
                    ]), flex: 7)]
                  )), padding: EdgeInsets.all(10)))))
        ]);
  }
}