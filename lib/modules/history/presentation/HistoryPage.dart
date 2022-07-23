import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/Route.dart' as rt;

import 'HistoryRouteListItem.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage>{

  List<rt.Route> routeList = [
    rt.Route(id: "0", name: "R100", cost: 25),
    rt.Route(id: "1", name: "R710", cost: 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Material(child: Column(children: [
      SizedBox(height: 70),
      Row(children: [
        SizedBox(width: 20),
        Text("History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
      ]),
      SizedBox(height: 20),
      Row(children: [
        SizedBox(width: 20),
        Text("Trips", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
      ]),
      Divider(thickness: 1),
      SizedBox(height: 20),
      Expanded(child: ListView.builder(itemCount: routeList.length,
          itemBuilder: (BuildContext context, int index){
            return HistoryRouteListItem(routeList[index]);
          }))
    ]));
  }
}