import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../models/Driver.dart';
import '../route_viewmodel.dart';
import 'ClientListItem.dart';

class ClientsListView extends StatefulWidget{
  final Driver _currentDriver;
  ClientsListView(this._currentDriver);
  final screenViewModel = Modular.get<RouteViewModel>();
  @override
  State<StatefulWidget> createState() => ClientListState();
}

class ClientListState extends State<ClientsListView>{
  @override
  Widget build(BuildContext context) {

    return ListView(
        padding: const EdgeInsets.all(8),
        children: widget.screenViewModel.clientList
            .map((client) => ClientItem(
            client,
            widget.screenViewModel.clientList.indexOf(client),
            widget._currentDriver))
            .toList());
  }

}