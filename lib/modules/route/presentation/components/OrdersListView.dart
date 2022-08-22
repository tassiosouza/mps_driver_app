import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/modules/route/presentation/RoutePage.dart';

import '../../../../models/Driver.dart';
import 'OrderItem.dart';

class OrdersListView extends StatefulWidget {
  final Driver _currentDriver;
  final List<MOrder>? _currentMOrders;
  final StateRoutePage _pageReference;
  const OrdersListView(
      this._currentDriver, this._currentMOrders, this._pageReference,
      {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => OrderListState();
}

class OrderListState extends State<OrdersListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: widget._currentMOrders!
            .map((order) => OrderItem(
                order,
                widget._currentMOrders!.indexOf(order),
                widget._currentDriver,
                widget._pageReference))
            .toList());
  }
}
