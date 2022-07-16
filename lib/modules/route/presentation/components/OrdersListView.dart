import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';

import '../../../../models/Driver.dart';
import '../route_viewmodel.dart';
import 'OrderItem.dart';

class OrdersListView extends StatefulWidget {
  final Driver _currentDriver;
  final List<MpsOrder> _currentMpsOrders;
  OrdersListView(this._currentDriver, this._currentMpsOrders, {Key? key})
      : super(key: key);
  final screenViewModel = Modular.get<RouteViewModel>();
  @override
  State<StatefulWidget> createState() => OrderListState();
}

class OrderListState extends State<OrdersListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: widget._currentMpsOrders
            .map((order) => OrderItem(order,
                widget._currentMpsOrders.indexOf(order), widget._currentDriver))
            .toList());
  }
}
