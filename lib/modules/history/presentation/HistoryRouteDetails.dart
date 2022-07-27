import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/models/Route.dart' as rt;
import 'package:mps_driver_app/modules/history/presentation/components/ListHistoryOrderItem.dart';

import '../../../theme/app_colors.dart';

class HistoryRouteDetails extends StatefulWidget{

  rt.Route route;
  HistoryRouteDetails(this.route);

  @override
  State<StatefulWidget> createState() => HistoryRouteDetailsState();
}

class HistoryRouteDetailsState extends State<HistoryRouteDetails>{
  @override
  Widget build(BuildContext context) {
    String routeName = "#Route ${widget.route.name}";
    MpsOrder order = MpsOrder(number: "5", routeID: "10");
    var listSize = 0;
    if(widget.route.orders == null){
      listSize = 0;
    } else {
      listSize = widget.route.orders!.length*30;
    }

    return Scaffold(body: SingleChildScrollView(child: Column(children: [
      Stack(children: [
        Align(child: Image.asset('assets/images/logo.png')),
        Align(child: Container(child: ElevatedButton(onPressed: () { Navigator.pop(context); },
            child: Container(child: Icon(Icons.arrow_back_ios, color: Colors.black), padding: EdgeInsets.only(left: 10),),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
                CircleBorder(side: const BorderSide(color: Colors.transparent))),
                padding: MaterialStateProperty.all(EdgeInsets.zero))),
        padding: EdgeInsets.only(top: 80, left: 30)), alignment: Alignment.topLeft)
      ]),
      Row(children: [
        SizedBox(width: 20),
        Text(routeName, style: TextStyle(fontSize: 18,
            color: App_Colors.primary_color.value, fontWeight: FontWeight.w500))
      ],),
      SizedBox(height: 25),
      Row(children: [
        SizedBox(width: 20),
        Column(children: [
          Icon(Icons.location_on_outlined, color: Colors.black, size: 20),
          Image.asset('assets/images/verticaldots.png', height: 10, scale: 0.2),
          Icon(Icons.location_on_outlined, color: Colors.black, size: 20)
        ],),
        SizedBox(width: 5),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Meal Prep Sunday", style: TextStyle(fontSize: 14)),
                Container(child: Text("09:10 AM"), padding: EdgeInsets.only(right: 20))
              ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("202 Island Avenue, CA 92101",
                  style: TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
                Container(child: Text("17:10 PM"), padding: EdgeInsets.only(right: 20))
              ]),
        ]))
      ]),
      SizedBox(height: 20),
      Divider(thickness: 1, color: App_Colors.grey_light.value),
      SizedBox(height: 25),
      Row(children: [
        SizedBox(width: 20),
        Expanded(child: Column(children: [
          getInfos("Distance", "26,2 m"),
          SizedBox(height: 15),
          getInfos("Time", "45 min")
        ])),
        SizedBox(width: 40),
        Expanded(child: Column(children: [
          getInfos("Bags delivered", "21"),
          SizedBox(height: 15),
          getInfos("Bags not delivered", "01")
        ])),
        SizedBox(width: 20)
      ]),
      SizedBox(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Total received", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                color: App_Colors.black_text.value)),
            SizedBox(width: 5),
            Text("\$25.00", style: TextStyle(color: App_Colors.primary_color.value,
            fontWeight: FontWeight.w500, fontSize: 20)),
            SizedBox(width: 15)
      ]),
      SizedBox(height: 15),
      Divider(thickness: 1, color: App_Colors.grey_light.value),
      SizedBox(height: 10),
      Container(child: ListView.builder(itemCount: widget.route.orders?.length,
          itemBuilder: (context, index){
        return ListHistoryOrderItem(order);
      }), height: 500)
    ])));
  }

  Widget getInfos(String info, String value){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(info, style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value)),
      Text(value, style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value))
    ]);
  }
}