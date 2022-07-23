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
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(title, style: TextStyle(fontSize: 14, color: App_Colors.primary_color.value,
                          fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      Row(children: [
                        Column(children: [
                          Icon(Icons.location_on_outlined, color: Colors.black, size: 20),
                          Image.asset('assets/images/verticaldots.png', height: 10, scale: 0.2),
                          Icon(Icons.location_on_outlined, color: Colors.black, size: 20)
                        ],),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Meal Prep Sunday", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 13),
                          Text("202 Island Avenue, CA 92101", style: TextStyle(fontSize: 12))
                        ],)
                      ],),
                      SizedBox(height: 15),
                      Row(children: [
                        SizedBox(width: 5),
                        Icon(Icons.watch_later_outlined, size: 20),
                        SizedBox(width: 5),
                        Text("08:00", style: TextStyle(fontSize: 12)),
                        Text(" - ", style: TextStyle(fontSize: 12)),
                        Text("16:00", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 40),
                        Icon(CustomIcon.bag_driver_icon, size: 20),
                        SizedBox(width: 10),
                        Text("22", style: TextStyle(fontSize: 12))
                      ],)
                    ]),
                    VerticalDivider(thickness: 1, color: App_Colors.grey_dark.value),
                    Column(children: [Text("teste")])]
                  )), padding: EdgeInsets.all(10)))))
        ]);
  }
}