// ignore: file_names
// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/modules/history/presentation/components/ListHistoryOrderItem.dart';

import '../../../theme/app_colors.dart';

// ignore: must_be_immutable
class HistoryRouteDetails extends StatefulWidget {
  MpsRoute route;
  HistoryRouteDetails(this.route, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HistoryRouteDetailsState();
}

class HistoryRouteDetailsState extends State<HistoryRouteDetails> {
  @override
  Widget build(BuildContext context) {
    String routeName = "#Route ${widget.route.name}";
    MpsOrder order = MpsOrder(number: "5", routeID: "10");
    if (widget.route.orders == null) {
    } else {}

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Stack(children: [
        Align(child: Image.asset('assets/images/logo.png')),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                padding: const EdgeInsets.only(top: 80, left: 30),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(const CircleBorder(
                            side: BorderSide(color: Colors.transparent))),
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                    ))))
      ]),
      Row(
        children: [
          const SizedBox(width: 20),
          Text(routeName,
              style: TextStyle(
                  fontSize: 18,
                  color: App_Colors.primary_color.value,
                  fontWeight: FontWeight.w500))
        ],
      ),
      const SizedBox(height: 25),
      Row(children: [
        const SizedBox(width: 20),
        Column(
          children: [
            const Icon(Icons.location_on_outlined,
                color: Colors.black, size: 20),
            Image.asset('assets/images/verticaldots.png',
                height: 10, scale: 0.2),
            const Icon(Icons.location_on_outlined,
                color: Colors.black, size: 20)
          ],
        ),
        const SizedBox(width: 5),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Meal Prep Sunday", style: TextStyle(fontSize: 14)),
            Container(
                padding: const EdgeInsets.only(right: 20),
                child: const Text("09:10 AM"))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("202 Island Avenue, CA 92101",
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis),
            Container(
                padding: const EdgeInsets.only(right: 20),
                child: const Text("17:10 PM"))
          ]),
        ]))
      ]),
      const SizedBox(height: 20),
      Divider(thickness: 1, color: App_Colors.grey_light.value),
      const SizedBox(height: 25),
      Row(children: [
        const SizedBox(width: 20),
        Expanded(
            child: Column(children: [
          getInfos("Distance", "26,2 m"),
          const SizedBox(height: 15),
          getInfos("Time", "45 min")
        ])),
        const SizedBox(width: 40),
        Expanded(
            child: Column(children: [
          getInfos("Bags delivered", "21"),
          const SizedBox(height: 15),
          getInfos("Bags not delivered", "01")
        ])),
        const SizedBox(width: 20)
      ]),
      const SizedBox(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Total received",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: App_Colors.black_text.value)),
        const SizedBox(width: 5),
        Text("\$25.00",
            style: TextStyle(
                color: App_Colors.primary_color.value,
                fontWeight: FontWeight.w500,
                fontSize: 20)),
        const SizedBox(width: 15)
      ]),
      const SizedBox(height: 15),
      Divider(thickness: 1, color: App_Colors.grey_light.value),
      const SizedBox(height: 10),
      Container(
          height: 500,
          child: ListView.builder(
              itemCount: widget.route.orders?.length,
              itemBuilder: (context, index) {
                return ListHistoryOrderItem(order);
              }))
    ])));
  }

  Widget getInfos(String info, String value) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(info,
          style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value)),
      Text(value,
          style: TextStyle(fontSize: 14, color: App_Colors.grey_text.value))
    ]);
  }
}
