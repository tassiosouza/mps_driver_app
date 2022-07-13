import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../models/Driver.dart';
import '../route_viewmodel.dart';
import 'OrderItem.dart';

class OrdersListView extends StatefulWidget {
  final Driver _currentDriver;
  OrdersListView(this._currentDriver);
  final screenViewModel = Modular.get<RouteViewModel>();
  @override
  State<StatefulWidget> createState() => OrderListState();
}

class OrderListState extends State<OrdersListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: widget.screenViewModel.orderList
            .map((order) => OrderItem(
                order,
                widget.screenViewModel.orderList.indexOf(order),
                widget._currentDriver))
            .toList());
  }
}
