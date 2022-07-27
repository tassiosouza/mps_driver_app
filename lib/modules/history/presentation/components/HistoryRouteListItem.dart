import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/theme/app_colors.dart';

import '../../../../models/MpsRoute.dart';
import '../../../../theme/CustomIcon.dart';

// ignore: must_be_immutable
class HistoryRouteListItem extends StatelessWidget {
  MpsRoute route;
  HistoryRouteListItem(this.route, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "#Route ${route.name}";

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.only(left: 20),
        child: Text("Today",
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
                                  Text(title,
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
                                              children: const [
                                            Text("Meal Prep Sunday",
                                                style: TextStyle(fontSize: 12)),
                                            SizedBox(height: 13),
                                            Text(
                                              "202 Island Avenue, CA 92101",
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ]))
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(children: const [
                                    Icon(Icons.watch_later_outlined, size: 18),
                                    SizedBox(width: 5),
                                    Text("08:00",
                                        style: TextStyle(fontSize: 12)),
                                    Text(" - ", style: TextStyle(fontSize: 12)),
                                    Text("16:00",
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(width: 30),
                                    Icon(CustomIcon.bag_driver_icon, size: 17),
                                    SizedBox(width: 5),
                                    Text("22", style: TextStyle(fontSize: 12))
                                  ])
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
                                          Text("26.2 m",
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
                                          Text("Time",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: App_Colors
                                                      .grey_text.value)),
                                          Text("27min",
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
                                          Text("\$40.00",
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
            Modular.to.pushNamed('./details', arguments: route);
          })
    ]);
  }
}
