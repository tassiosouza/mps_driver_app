// ignore: file_names
// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/modules/history/presentation/components/ListHistoryOrderItem.dart';
import 'package:mps_driver_app/utils/Utils.dart';

import '../../../theme/app_colors.dart';

// ignore: must_be_immutable
class HistoryRouteDetails extends StatefulWidget {
  MpsRoute route;
  HistoryRouteDetails(this.route, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HistoryRouteDetailsState();
}

class HistoryRouteDetailsState extends State<HistoryRouteDetails> {
  String getFormattedAddress() {
    MpsOrder lastOrder = widget.route.orders![widget.route.orders!.length - 1];
    int zipcodeIndex = lastOrder.customer!.address.split(',').length - 1;
    String street = lastOrder.customer!.address.split(',')[0];
    String zipcode = lastOrder.customer!.address.split(',')[zipcodeIndex];
    return '$street, $zipcode';
  }

  int getBagsDeliveredCount() {
    int result = 0;
    for (MpsOrder order in widget.route.orders ?? []) {
      result = result + (order.status == OrderStatus.DELIVERED ? 1 : 0);
    }
    return result;
  }

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
                child:
                    Text(Utils.getFormattedTime(widget.route.startTime, true)))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(getFormattedAddress(),
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis),
            Container(
                padding: const EdgeInsets.only(right: 20),
                child: Text(Utils.getFormattedTime(widget.route.endTime, true)))
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
          getInfos("Distance",
              Utils.getFormattedDistance(widget.route.distance, false)),
          const SizedBox(height: 15),
          getInfos(
              "Duration", Utils.getFormattedDuration(widget.route.duration))
        ])),
        const SizedBox(width: 40),
        Expanded(
            child: Column(children: [
          getInfos("Bags delivered", getBagsDeliveredCount().toString()),
          const SizedBox(height: 15),
          getInfos(
              "Bags not delivered",
              (widget.route.orders!.length - getBagsDeliveredCount())
                  .toString())
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
        const SizedBox(width: 10),
        Text("N/A",
            style: TextStyle(
                color: App_Colors.primary_color.value,
                fontWeight: FontWeight.w500,
                fontSize: 17)),
        const SizedBox(width: 15)
      ]),
      const SizedBox(height: 15),
      Divider(thickness: 1, color: App_Colors.grey_light.value),
      Container(
          height: 500,
          child: ListView.builder(
              itemCount: widget.route.orders!.length,
              itemBuilder: (context, index) {
                return ListHistoryOrderItem(widget.route.orders![index]);
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
