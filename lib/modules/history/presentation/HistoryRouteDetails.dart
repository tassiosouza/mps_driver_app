import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/Route.dart' as rt;

class HistoryRouteDetails extends StatefulWidget{

  rt.Route route;
  HistoryRouteDetails(this.route);

  @override
  State<StatefulWidget> createState() => HistoryRouteDetailsState();
}

class HistoryRouteDetailsState extends State<HistoryRouteDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      SizedBox(height: 100),
      Row(children: [
        Container(child: Text(widget.route.name, style: TextStyle()))
      ],),
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
      ],)
    ],));
  }

}