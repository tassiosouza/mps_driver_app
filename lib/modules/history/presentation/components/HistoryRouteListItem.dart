import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/theme/app_colors.dart';

import '../../../../models/MOrder.dart';
import '../../../../models/MRoute.dart';
import '../../../../theme/CustomIcon.dart';
import '../../../../utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// ignore: must_be_immutable
class HistoryRouteListItem extends StatelessWidget {
  MRoute? route;
  List<MOrder?>? orders;
  HistoryRouteListItem(this.route, this.orders, {Key? key}) : super(key: key);

  String getFormattedAddress() {
    MOrder? lastOrder = orders![orders!.length - 1];
    int zipcodeIndex = lastOrder!.address!.split(',').length - 1;
    String street = lastOrder.address!.split(',')[0];
    String zipcode = lastOrder.address!.split(',')[zipcodeIndex];
    return '$street, $zipcode';
  }

  @override
  Widget build(BuildContext context) {
    String title = route!.id.split('.')[0];

    String getVerboseDateTimeRepresentation(double? temporalTimestamp) {
      DateTime datetime = DateTime.fromMillisecondsSinceEpoch(1000);
      DateTime now = DateTime.now();
      DateTime justNow = now.subtract(Duration(minutes: 1));
      DateTime localDateTime = datetime.toLocal();

      if (!datetime.difference(justNow).isNegative) {
        return 'Today';
      }

      String roughTimeString = DateFormat('jm').format(datetime);

      if (datetime.day == now.day &&
          datetime.month == now.month &&
          datetime.year == now.year) {
        return 'Today';
      }

      DateTime yesterday = now.subtract(Duration(days: 1));

      if (datetime.day == yesterday.day &&
          datetime.month == now.month &&
          datetime.year == now.year) {
        return 'Yesterday';
      }

      if (now.difference(datetime).inDays < 4) {
        String weekday = DateFormat('yyyy-MM-dd hh:mm').format(datetime);

        return '$weekday, $roughTimeString';
      }

      return '${DateFormat('yyyy-MM-dd hh:mm').format(datetime)}, $roughTimeString';
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.only(left: 20),
        child: Text(getVerboseDateTimeRepresentation(route!.startTime),
            style: TextStyle(fontSize: 12, color: App_Colors.grey_text.value)),
      ),
      GestureDetector(
          child: Container(
              padding: const EdgeInsets.only(top: 5),
              margin: EdgeInsets.zero,
              child: Card(
                  elevation: 0,
                  margin:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          width: 1, color: App_Colors.grey_light.value)),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: IntrinsicHeight(
                          child: Row(children: [
                        Flexible(
                            flex: 13,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(' $title',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: App_Colors.primary_color.value,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(Icons.location_on_outlined,
                                              color: Colors.black, size: 20),
                                          Image.asset(
                                              'assets/images/verticaldots.png',
                                              height: 10,
                                              scale: 0.2),
                                          const Icon(Icons.location_on_outlined,
                                              color: Colors.black, size: 20)
                                        ],
                                      ),
                                      Flexible(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            const Text("Meal Prep Sunday",
                                                style: TextStyle(fontSize: 12)),
                                            const SizedBox(height: 13),
                                            Text(
                                              getFormattedAddress(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ]))
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Row(children: [
                                        const Icon(Icons.watch_later_outlined,
                                            size: 18),
                                        const SizedBox(width: 5),
                                        Text(
                                            Utils.getFormattedTime(
                                                route!.startTime, false),
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const Text(" - ",
                                            style: TextStyle(fontSize: 12)),
                                        Text(
                                            Utils.getFormattedTime(
                                                route!.endTime, false),
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 50),
                                        const Icon(CustomIcon.bag_driver_icon,
                                            size: 17),
                                        const SizedBox(width: 5),
                                        Text(orders!.length.toString(),
                                            style:
                                                const TextStyle(fontSize: 12))
                                      ]))
                                ])),
                        VerticalDivider(
                            thickness: 1, color: App_Colors.grey_dark.value),
                        Flexible(
                            flex: 7,
                            child: Column(children: [
                              Flexible(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Distance",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: App_Colors
                                                      .grey_text.value)),
                                          Text(
                                              Utils.getFormattedDistance(
                                                  route!.distance, true),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: App_Colors
                                                      .grey_text.value))
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Duration",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: App_Colors
                                                      .grey_text.value)),
                                          Text(
                                              Utils.getFormattedDuration(
                                                  route!.duration),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: App_Colors
                                                      .grey_text.value))
                                        ],
                                      ),
                                    ],
                                  )),
                              Divider(
                                thickness: 1,
                                color: App_Colors.grey_dark.value,
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Total",
                                              style: TextStyle(fontSize: 12)),
                                          Text("N/A",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: App_Colors
                                                      .primary_color.value,
                                                  fontWeight: FontWeight.w500))
                                        ],
                                      ),
                                    ],
                                  ))
                            ]))
                      ]))))),
          onTap: () {
            Modular.to.pushNamed('./details', arguments: {route, orders});
          })
    ]);
  }
}
